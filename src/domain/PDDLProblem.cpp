#include "PDDLProblem.h"
#include <pddlboat/parser/parser.hpp>
#include <pddlboat/parser/translator.hpp>
#include <iostream>
#include <sstream>
#include <cassert>
#include <fstream>
#include <filesystem>  // Requires C++17
#include <pthread.h>

class TimeoutException : public std::runtime_error {
public:
    explicit TimeoutException(const std::string& message)
        : std::runtime_error(message) {}
};

void PDDLProblem::constructDFAWithPromise(
    std::shared_ptr<DFAManager> dfa_manager, 
    LTLFormula formula, 
    std::promise<void> dfa_promise
) {
    try {
        dfa_manager->construct_dfa(formula);
        dfa_promise.set_value();  // Notify success
    } catch (...) {
        dfa_promise.set_exception(std::current_exception());  // Propagate exceptions
    }
}

PDDLProblem::PDDLProblem(const string& problemFile, shared_ptr<PDDLDomain> domainPtr, const string& planner_type, const string& search_type, const string& name_connector, bool cache, bool feedback, bool use_landmarks, bool hamming_dist, bool save_dfa, size_t subproblem_timeout, int backtracks_limit, size_t max_num_wrong_dfa_trans) 
: domain_(domainPtr), planner_type_(planner_type), search_type_(search_type),
name_connector_(name_connector), cache_(cache), feedback_(feedback),
use_landmarks_(use_landmarks), hamming_dist_(hamming_dist), save_dfa_(save_dfa), bdd_dict_(make_shared<spot::bdd_dict>()), num_expanded_nodes_(0), subproblem_timeout_(subproblem_timeout), backtracks_limit_(backtracks_limit), max_num_wrong_dfa_trans_(max_num_wrong_dfa_trans) {

    // Extracting the problem name
    extract_names(problemFile);

    parseProblem(problemFile, domainPtr);
    // cout << "Problem was parsed!!!" << endl;
    // pddlProblem_->toPDDL(std::cout) << std::endl;

    // Set a start position.
    start_domain_state_ = make_shared<PDDLState>(pddlProblem_->start);

    map<string, pair<string, vector<string>>> pred_mapping;
    // Set a mapping from propositions to grounded predicates.
    pddlProblem_->goal->getAtomicPropsMap(pred_mapping);
    // for (const auto& p: pred_mapping) {
    //     cout << "Pred is " << p.first << endl;
    // }
    // cout << "pred_mapping size is " << pred_mapping.size() << endl;


    // Initialize a dfa manager.
    dfa_manager_ = make_shared<DFAManager>(bdd_dict_, feedback_, hamming_dist_);

    // std::cout << "Creating a DFA for the problem " << problem_name_ << endl;
    // Create a name for output files.
    filename_ = problem_name_ + "_pddl_dfa";

    // std::cout << "The output file will be named: " << filename_ << endl;

    auto start1 = chrono::high_resolution_clock::now();

    // Convert to formula_str to LTLFormula object.
    formula_ = LTLFormula(pddlProblem_->goal->toLTL(), pred_mapping);

    // cout << "Formula: " << formula_ << endl;

    // Compute the DFA corresponding to the given LTL formula.
    // dfa_manager_->construct_dfa(formula_);

    // Use std::promise and std::future to manage DFA construction thread
    std::promise<void> dfa_promise;
    std::future<void> dfa_future = dfa_promise.get_future();

    // Start the DFA construction thread
    std::thread dfa_thread(
        &PDDLProblem::constructDFAWithPromise, this, 
        dfa_manager_, formula_, std::move(dfa_promise)
    );

    // std::future<void> dfa_future = std::async(std::launch::async, [&]() {
    //     dfa_manager_->construct_dfa(formula_);
    // });

    // Set the timeout duration to 1 hour
    std::chrono::hours timeout_duration(1);
    // std::chrono::seconds timeout_duration(1);

    if (dfa_future.wait_for(timeout_duration) == std::future_status::timeout) {
        std::cerr << "Error: DFA construction timed out." << std::endl;
        
        // If the thread is still running, join it safely
        if (dfa_thread.joinable()) {
            dfa_thread.detach();  // Wait for it to finish properly
        }

        // Throw a TimeoutException to exit the constructor safely
        throw TimeoutException("TimeoutException: DFA construction timed out.");
    } 

    // Check for exceptions from the DFA construction
    try {
        dfa_future.get();  // Retrieve the result or propagate exceptions
    } catch (const std::exception& e) {
        std::cerr << "Error during DFA construction: " << e.what() << std::endl;
        if (dfa_thread.joinable()) {
            dfa_thread.join();
        }
        throw;  // Re-throw the exception to signal failure
    }

    if (dfa_thread.joinable()) {
        dfa_thread.join();  // Ensure the thread is properly joined
    }


    auto end1 = chrono::high_resolution_clock::now();
    dfa_construction_time_ = end1 - start1;
    std::cout << "Time for constructing an automaton: " << dfa_construction_time_.count() << " seconds" << std::endl;

    // dfa_manager_->print_dfa();
    if (save_dfa_) {
        dfa_manager_->save_dfa(filename_, domain_name_);
    }
    // cout << "DFA was generated" << endl;

    // Initialize domain and product managers.
    domain_manager_ = make_shared<DomainManager>(bdd_dict_, domain_, get_pred_mapping());

    product_manager_ = make_shared<ProductManager>(domain_manager_, dfa_manager_);

}

PDDLProblem::~PDDLProblem() {
    // Unregister all propositions: need for memory management.
    bdd_dict_->unregister_all_my_variables(nullptr);
    // When the reference count drops to zero, the destructor for the spot::bdd_dict will be triggered.
}

void PDDLProblem::parseProblem(const std::string& problemFile, std::shared_ptr<PDDLDomain> domainPtr) {
    auto pddlboatDomainPtr = domainPtr->getPddlboatDomainPtr();

    pddlboat::ast::Problem problem_ast;
    if (!pddlboat::parseFile(problemFile, problem_ast)) {
        throw std::runtime_error("Failed to parse PDDL problem file: " + problemFile);
    }

    try {
        pddlProblem_ = pddlboat::toProblem(problem_ast, pddlboatDomainPtr);
    } catch (const std::exception& e) {
        throw std::runtime_error("Exception translating problem: " + std::string(e.what()));
    }
}

const pddlboat::ProblemPtr& PDDLProblem::getPddlboatProblemPtr() const {
    return pddlProblem_;
}

vector<ProductState> PDDLProblem::solve() {
    // Clear any existing paths from previous executions.
    product_path_.clear();
    dfa_path_.clear();

    // Retrieve the start state of the DFA.
    size_t dfa_start_state = dfa_manager_->get_start_state();
    // Error if the DFA is trivial (only a single accepting state).
    if (dfa_manager_->is_accepting_state(dfa_start_state)) {
        cerr << "ERROR: DFA has a single state. LTL formula is not descriptive enough." << endl;
        return {};
    }

    // Initializethe priority queue for the DFA paths from the start DFA state.
    dfa_manager_->initialize_node_priority_queue();
    num_of_backtracks_ = -1;

    // Backtracking loop to find a valid product path.
    while (product_path_.empty() && num_of_backtracks_ < backtracks_limit_) {
        num_of_backtracks_++;
        // Generate a likely DFA trace that leads to an acceptance state.
        auto end_trace_node = dfa_manager_->generate_dfa_path();
        // If no more DFA traces are available, exit the loop.
        if (!end_trace_node) {
            break;
        }

        // Attempt to realize the current DFA trace in the task domain.
        realize_dfa_trace(end_trace_node);
    }
    // Return the product path, or an empty vector if no solution was found.
    return product_path_;
}

void PDDLProblem::realize_dfa_trace(shared_ptr<DFANode>& end_trace_node) {

    if (planner_type_ != "manual") {
        // 1. Create an instanse of the subproblem 
        // 2. Call the off-the-shelf planner
        realize_dfa_trace_with_planner(end_trace_node);
    } else {
        realize_dfa_trace_manually(end_trace_node);
    }
}

void PDDLProblem::realize_dfa_trace_manually(shared_ptr<DFANode>& end_trace_node) {

    auto dfa_trace = end_trace_node->getPathFromRoot();
    auto dfa_nodes = end_trace_node->getNodePathFromRoot();

    if (!validate_dfa_trace(dfa_trace)) return;

    size_t dfa_start_state = dfa_trace.front();
    ProductState start_state(start_domain_state_, dfa_start_state);

    size_t currentRegionIndex = 0;
    size_t maxRegionIndexReached = 0;

    set<ProductState> visited;
    visited.insert(start_state);

    // Initialize a map of priority queues 
    // (one queue for each DFA state in the trace)
    map<size_t, priority_queue<pair<int, ProductState>, vector<pair<int, ProductState>>, greater<pair<int, ProductState>>>> regionQueues;
    map<ProductState, vector<ProductState>> parent_map;
    map<size_t, DomainStateSet> landmarks; 

    int curr_state_heuristic = 0;
    if (use_landmarks_) {
        auto next_dfa_edge_condition = dfa_nodes.at(1)->getParentEdgeCondition();
        landmarks[dfa_start_state] = product_manager_->sample_landmarks(next_dfa_edge_condition, start_domain_state_);
        curr_state_heuristic = compute_heuristics(start_state, landmarks, dfa_start_state);
    }

    enqueue_product_state(regionQueues, start_state, curr_state_heuristic, dfa_start_state);

    size_t curr_num_wrong_dfa_trans = 0;

    while (!regionQueues[dfa_start_state].empty()) {
        size_t curr_dfa_state = dfa_trace.at(currentRegionIndex);    
        auto& queue = regionQueues[curr_dfa_state];

        if (queue.empty()) {
            // Backtrack if necessary
            assert(currentRegionIndex > 0 && "currentRegionIndex must be positive");
            currentRegionIndex--;
            continue;
        }
        // if (queue.size() == 1) {
        //     cout << "Trying to realize this transition: " << curr_dfa_state << "=>" << dfa_trace.at(currentRegionIndex+1) << endl;
        // }
        // Queue is not empty!
        auto current_state_pair = queue.top();
        ProductState current_state = current_state_pair.second;
        queue.pop();

        // Check if state was expanded?
        // If not, then generate successors for this state!
        if (product_manager_->state_not_expanded(current_state)) {
            // Expand the state.
            num_expanded_nodes_++;
            product_manager_->generate_successors(current_state);
        }

        for (auto& transition : product_manager_->get_transitions(current_state)) {
            // Get the product state where this transition leads. 
            ProductState next_state = transition.out_state();
            // Check if it was already explored.
            if (visited.find(next_state) != visited.end()) continue;
            // This state has been visited now!
            visited.insert(next_state);

            // Get the next dfa state.
            size_t next_dfa_state = next_state.get_dfa_state();

            // We are interested only in the transitions that either stay in the same dfa state or lead to the next dfa state in the trace.
            if (next_dfa_state != dfa_trace.at(currentRegionIndex) &&
            next_dfa_state != dfa_trace.at(currentRegionIndex + 1)) {
                // Skip states that lead to any other dfa states.
                // Update cost for this transition to 0.
                if (feedback_ && dfa_manager_->dfa_transition_cost(curr_dfa_state, next_dfa_state) != SUCCESS_COST) {
                    dfa_manager_->update_dfa_transition_cost(curr_dfa_state, next_dfa_state, SUCCESS_COST);
                    // Cache this for future reuse.
                    // TODO: implement caching!
                    // if (cache_ && !transition.isCached()) {
                    //     vector<ProductState> path_to_cache_reversed = construct_path(parent_map, next_state, true, curr_dfa_state);
                    //     // Now we create a transition and add it to a product graph.
                    //     // Serves as a "skip-connection".
                    //     product_manager_->cache_path(path_to_cache_reversed, transition.dfa_edge_condition());
                    // }
                }
                if (!handle_wrong_transitions(curr_num_wrong_dfa_trans, dfa_nodes.back(), dfa_nodes.at(currentRegionIndex + 1))) {
                    return;
                }
                continue;
            }

            // cout << "Transitioning: " << curr_dfa_state << "=>" << next_dfa_state << endl;

            // Add it to the parent map to be able to backtrack.
            parent_map[next_state] = transition.path();

 
            if (next_dfa_state == dfa_trace.at(currentRegionIndex + 1)) {
                // We were able to get to the next DFA state in a trace!
                // cout << "Succesfully realized this transition: " << transition.in_state().get_dfa_state() << "=>" << transition.out_state().get_dfa_state() << endl; 

                curr_num_wrong_dfa_trans = 0;

                // Update the cost to 0 based on the success of the transition.
                dfa_manager_->update_dfa_transition_cost(dfa_nodes.at(currentRegionIndex + 1), SUCCESS_COST);

                // Optimization 1: cache paths that cross the dfa states
                if (cache_ && !transition.isCached()) {

                    vector<ProductState> path_to_cache_reversed = construct_path(parent_map, next_state, true, curr_dfa_state);

                    // Now we create a transition and add it to a product graph.
                    // Serves as a "skip-connection".
                    product_manager_->cache_path(path_to_cache_reversed, transition.dfa_edge_condition());

                    // TODO: cache it as a path between modalities in DomainManager (can be reused for other TEG problems).
                }

                currentRegionIndex++;

                // Remember the last dfa state we were able to reach.
                if (maxRegionIndexReached < currentRegionIndex) {
                    maxRegionIndexReached = currentRegionIndex;
                }
                // Check if it's the accepting state (last in the dfa trace).
                // If so, we have a solution!
                if (currentRegionIndex == dfa_trace.size() - 1) {
                    // Backtrack to get the full path.
                    product_path_ = construct_path(parent_map, next_state);
                    save_paths();
                    return;
                }

                // Compute landmarks for the next DFA region:
                // 1) Sample k points in the next equivalence region (aka landmarks). 
                // 2) Define heuristic as a distance to the closest sampled point.
                // 3) Not an admissible heuristic but we don't care about optimality of the path, so it's fine.

                // TODO: debug landmarks approach later.
                if (use_landmarks_ && landmarks.count(next_dfa_state) == 0) {
                    auto next_dfa_edge_condition = dfa_nodes.at(currentRegionIndex + 1)->getParentEdgeCondition();
                    landmarks[next_dfa_state] = product_manager_->sample_landmarks(next_dfa_edge_condition, next_state.get_domain_state());
                }
            } 
            // Compute the heuristic score for this state and push it into the queue.
            int next_state_cost = current_state_pair.first + DEFAULT_COST; 
            if (use_landmarks_) {
                int curr_heuristic_cost = compute_heuristics(current_state, landmarks, curr_dfa_state);
                int next_heuristic_cost = compute_heuristics(next_state, landmarks, next_dfa_state);
                next_state_cost += (next_heuristic_cost - curr_heuristic_cost);
            }

            // Push this new product state onto the corresponding queue.
            enqueue_product_state(regionQueues, next_state, next_state_cost, next_dfa_state);
        }
    }
    // We failed to realize the provided dfa trace.
    // Update the cost for the dfa transition we couldn't realize.
    dfa_manager_->update_dfa_transition_cost(dfa_nodes.at(maxRegionIndexReached + 1), FAILURE_COST);
}

void PDDLProblem::realize_dfa_trace_with_planner(shared_ptr<DFANode>& end_trace_node) {

    auto dfa_trace = end_trace_node->getPathFromRoot();
    auto dfa_nodes = end_trace_node->getNodePathFromRoot();

    if (!validate_dfa_trace(dfa_trace)) return;

    size_t currentRegionIndex = 0;
    size_t maxRegionIndexReached = 0;
    int max_num_wrong_dfa_trans = 3;
    int max_num_repeated_paths = 1;
    int num_wrong_dfa_trans = 0;
    int num_repeated_paths = 0;

    set<ProductState> visited;
    // map<size_t, pddlboat::ProblemPtr> regionSubproblems;
    map<size_t, vector<pair<shared_ptr<pddlboat::Plan::Step>, pddlboat::ProblemPtr>>> regionSubproblems;
    map<ProductState, vector<ProductState>> parent_map;

    size_t dfa_start_state = dfa_trace.front();
    ProductState start_state(start_domain_state_, dfa_start_state);
    visited.insert(start_state);

    // Instantiate a subproblem for the first transition
    auto start_subproblems = create_subproblem(dfa_nodes.at(1)->getParentEdgeCondition(), dfa_nodes.at(0)->getSelfEdgeCondition(),start_domain_state_);
    regionSubproblems.insert({dfa_start_state, start_subproblems});
    
    while (!regionSubproblems.empty()) {
        size_t curr_dfa_state = dfa_trace.at(currentRegionIndex);
        size_t next_dfa_state = dfa_trace.at(currentRegionIndex + 1);
        ProductState next_prod_state(next_dfa_state);
        auto last_domain_state = start_domain_state_;
        // cout << "Trying to realize a transition: " << curr_dfa_state << "=>" << next_dfa_state << endl;
        // Check if there are remaining subproblems for the current DFA state
        if (regionSubproblems.count(curr_dfa_state) == 0 || (regionSubproblems.at(curr_dfa_state).empty())) {
            // Backtrack if necessary
            if (currentRegionIndex == 0) {
                // cerr << "Failed to realize DFA trace. No more subproblems to try." << endl;
                return;
            }
            currentRegionIndex--;
            continue;  
        }
        // Pop the next <prefix_step, subproblem> pair to try
        auto [prefix_step, subproblem] = regionSubproblems[curr_dfa_state].back();
        regionSubproblems[curr_dfa_state].pop_back();

        if (!prefix_step) {
            // cout << "Prefix plan is empty; skipping prepend step." << endl;
        } else {
            // cout << "Considering a prefix step: " << endl;
            // prefix_step->toString(std::cout) << endl;
            // Create PDDLStates from the prior and new states of the step
            auto prior_domain_state = make_shared<PDDLState>(prefix_step->prior->clone());
            last_domain_state = make_shared<PDDLState>(prefix_step->state->clone());
            size_t dfa_state_after_step = (subproblem == nullptr) ? next_dfa_state : curr_dfa_state;

            // Create corresponding product states
            ProductState prior_product_state(prior_domain_state, curr_dfa_state, prefix_step);
            next_prod_state = ProductState(last_domain_state, dfa_state_after_step);

            // Add this subplan to the map for easy retrieval. 
            parent_map[next_prod_state] = {prior_product_state};
        }

        if (subproblem) {
            // std::cout << "Solving subproblem for DFA state: " << curr_dfa_state << std::endl;
            // subproblem->goal->toPDDL(std::cout) << std::endl;

            auto curr_domain_state = make_shared<PDDLState>(subproblem->start);
            // Deal with the prefix-plan.
            ProductState curr_prod_state(curr_domain_state, curr_dfa_state);

            bool retrieved_path = false;

            if (cache_) {
                // Retrieve the cached solution if one exists.
                for (auto &transition : product_manager_->get_transitions(curr_prod_state)) {
                    next_prod_state = transition.out_state();
                    
                    if (next_prod_state.get_dfa_state() == next_dfa_state) {
                        // Cached solution found
                        cout << "WARNING: Using a cached solution!" << endl;
                        // Add it to the parent map to be able to backtrack.
                        parent_map[next_prod_state] = transition.path();
                        last_domain_state = static_pointer_cast<PDDLState>(next_prod_state.get_domain_state());
                        retrieved_path = true;
                    }
                }
            }

            if (!retrieved_path) {
                // Use the planner to solve the subproblem
                // Instantiate the planner based on the type
                shared_ptr<pddlboat::Planner> task_planner = get_task_planner(subproblem);
                if (!task_planner) {
                    cerr<< "ERROR: no task planner initialized!!!!"<< endl;
                    exit(EXIT_FAILURE);
                }
                auto plan = make_shared<pddlboat::Plan>(subproblem);
                if (!task_planner->solve(*plan, subproblem_timeout_))
                {
                    if (regionSubproblems.at(curr_dfa_state).empty()) {
                        regionSubproblems.erase(curr_dfa_state);
                    }
                    continue;
                }

                // cout << "Plan for subproblem: " << endl << *plan << endl;

                // Retrieve the plan's steps (which includes actions and states)
                auto plan_steps = plan->getSteps();
                if (plan_steps.empty()) {
                    cerr << "ERROR: the plan is empty! Search failed." << endl;
                    regionSubproblems.clear(); // Finish the search
                    continue;
                }
                
                // Get the final state from the plan and check if it satisfies the DFA edge condition
                last_domain_state = make_shared<PDDLState>(plan_steps.back().state->clone());
                next_prod_state = ProductState(last_domain_state, next_dfa_state);

                // Check if it was already explored.
                if (visited.find(next_prod_state) != visited.end()) {
                    // Skip this state.
                    // TODO: modify the problem to avoid this domain state?
                    num_repeated_paths++;
                    // cout << "ERROR: Found a previously explored path to the dfa state " << next_dfa_state << endl;
                    if (num_repeated_paths >= max_num_repeated_paths) {
                        // cerr << "Failed to find the alternative path! Search failed." << endl;
                        // TODO: figure out what to do to not get stuck.
                        regionSubproblems.clear(); // Finish the search
                    }
                    continue;
                }
                // Visit the state.
                visited.insert(next_prod_state);

                // Get a bdd corresponding to last PDDL state.
                bdd last_domain_state_bdd = domain_manager_->get_state_bdd(last_domain_state);
                // Get a bdd corresponding to the transition in the DFA.
                bdd next_edge_cond = dfa_nodes.at(currentRegionIndex+1)->getParentEdgeCondition();

                if (!dfa_manager_->is_transition_valid(next_edge_cond, last_domain_state_bdd)) {
                    cout << "ERROR: Transition doesn't satisfy an edge condition for " << curr_dfa_state << "->" << next_dfa_state << endl;
                    continue;
                }

                bool valid_dfa_state = true;
                vector<ProductState> product_path;

                // Iterate over the steps to create corresponding ProductStates
                for (int i = plan_steps.size() - 1; i >= 0; --i) {
                    // Extract the current step and wrap it in a shared pointer
                    auto current_step = make_shared<pddlboat::Plan::Step>(plan_steps.at(i));

                    // Create a PDDLState from the prior state of the step
                    auto domain_state = make_shared<PDDLState>(current_step->prior->clone());

                    // Get a BDD corresponding to this PDDL state
                    bdd domain_state_bdd = domain_manager_->get_state_bdd(domain_state);

                    // Verify that domain states correspond to the current DFA state
                    // TODO: double check what this does
                    if (!((i == 0) || dfa_manager_->is_transition_valid(dfa_nodes.at(currentRegionIndex)->getSelfEdgeCondition(), domain_state_bdd))) {
                        valid_dfa_state = false;
                    }

                    // Create a ProductState with the Plan::Step and push it to the product_path_
                    product_path.emplace_back(domain_state, curr_dfa_state, current_step);
                }

                // Implement max threshold for the number of wrong transitions.
                if (!valid_dfa_state) {
                    num_wrong_dfa_trans++;
                    // cout << "ERROR: Solution path goes beyond the dfa state = " << curr_dfa_state << endl;
                    if (num_wrong_dfa_trans >= max_num_wrong_dfa_trans) {
                        // cerr << "Failed to solve within the same dfa region!" << endl;
                        regionSubproblems.erase(curr_dfa_state);
                    }
                    continue;
                }

                // We were able to get to the next DFA state in a trace!
                // cout << "Succesfully realized this transition: " << curr_dfa_state << "=>" << next_dfa_state << endl;

                num_wrong_dfa_trans = 0;
                num_repeated_paths = 0;

                // Add it to the parent map to be able to backtrack.
                parent_map[next_prod_state] = product_path;  

                // Update the cost to 0 based on the success of the transition.
                dfa_manager_->update_dfa_transition_cost(dfa_nodes.at(currentRegionIndex + 1), SUCCESS_COST);

                // Optimization 1: cache paths that cross the dfa states
                if (cache_) {
                    vector<ProductState> path_to_cache_reversed = construct_path(parent_map, next_prod_state, true, curr_dfa_state);

                    // Now we create a transition and add it to a product graph.
                    // Serves as a "skip-connection".
                    product_manager_->cache_path(path_to_cache_reversed, next_edge_cond);
                }
            }
        }

        currentRegionIndex++;

        // Remember the last dfa state we were able to reach.
        if (maxRegionIndexReached < currentRegionIndex) {
            maxRegionIndexReached = currentRegionIndex;
        }
        // Check if it's the accepting state (last in the dfa trace).
        // If so, we have a solution!
        if (currentRegionIndex == dfa_trace.size() - 1) {
            // Backtrack to get the full path.
            product_path_ = construct_path(parent_map, next_prod_state);
            save_paths();
            return;
        }

        // Instantiate a subproblem.
        auto next_subproblems = create_subproblem(dfa_nodes.at(currentRegionIndex+1)->getParentEdgeCondition(), dfa_nodes.at(currentRegionIndex)->getSelfEdgeCondition(), last_domain_state);
        regionSubproblems.insert({next_dfa_state, next_subproblems});
    } 
    // We failed to realize the provided dfa trace.
    // Update the cost for the dfa transition we couldn't realize.
    dfa_manager_->update_dfa_transition_cost(dfa_nodes.at(maxRegionIndexReached + 1), FAILURE_COST);
}

vector<ProductState> PDDLProblem::construct_path(const map<ProductState, vector<ProductState>>& parent_map, ProductState target_state, bool cached, size_t start_dfa_state) {
    vector<ProductState> path;
    path.push_back(target_state);

    while (parent_map.find(target_state) != parent_map.end()) {

        const auto& preceding_path = parent_map.at(target_state);

        target_state = preceding_path.back();

        if (cached && target_state.get_dfa_state() != start_dfa_state) {
            // We only want to cache 1-step dfa transitions for now.
            break;
        } 

        path.insert(path.end(), preceding_path.begin(), preceding_path.end());
    }

    if (!cached) {
        reverse(path.begin(), path.end());
    }
    return path;
}

void PDDLProblem::save_paths() {
    domain_path_.clear();
    dfa_path_.clear();
    int prev_dfa_state = -1;
    for(const auto& ps : product_path_) {
        domain_path_.push_back(ps.get_domain_state());
        int curr_dfa_state = ps.get_dfa_state();
        if (prev_dfa_state != curr_dfa_state) {
            dfa_path_.push_back(curr_dfa_state);
            prev_dfa_state = curr_dfa_state;
        }
    }
}

vector<shared_ptr<DomainState>> PDDLProblem::get_domain_path() const {
    return domain_path_;
}

vector<size_t> PDDLProblem::get_dfa_path() const {
    return dfa_path_;
}

void PDDLProblem::print_product_path() const {
    std::cout << "Product Path:" << endl;
    if (!product_path_.empty()) {
        std::cout << product_path_.front();
        for (auto it = next(product_path_.begin()); it != product_path_.end(); ++it) {
            std::cout << " -> " << *it;
        }
    }
    std::cout << endl;
}

void PDDLProblem::print_domain_path() const {
    std::cout << "Domain Path:" << endl;
    if (!domain_path_.empty()) {
        std::cout << *domain_path_.front();
        for (auto it = next(domain_path_.begin()); it != domain_path_.end(); ++it) {
            std::cout << " -> " << **it;
        }
    }
    std::cout << endl;
}

void PDDLProblem::print_dfa_path() const {
    dfa_manager_->print_dfa_path(dfa_path_);
}

string PDDLProblem::get_filename() const {
    return filename_;
}

map<string, pair<string, vector<string>>> PDDLProblem::get_pred_mapping() const {
    return formula_.get_pred_mapping();
}

double PDDLProblem::get_dfa_construction_time() const {
    return dfa_construction_time_.count();
}

size_t PDDLProblem::get_num_generated_nodes() const {
    return product_manager_->get_num_expanded_nodes();
}
size_t PDDLProblem::get_num_expanded_nodes() const {
    return num_expanded_nodes_;
}

size_t PDDLProblem::get_num_of_backtracks() const {
    return num_of_backtracks_;
}

size_t PDDLProblem::get_plan_length() const {
    if (domain_path_.empty()) {
        return 0;
    }
    return domain_path_.size() - 1;
}

// Old version of subproblem. 
// pddlboat::ProblemPtr PDDLProblem::create_subproblem(bdd& edge_cond, shared_ptr<PDDLState> start_state) {
//     // Step 1: Collect required predicates that must hold in all conjunctions
//     bdd required_predicates_bdd;
//     auto bound_predicates = collect_bound_predicates(edge_cond, required_predicates_bdd);

//     // If bound_predicates is empty, it means there are no universally required predicates
//     bool has_required_predicates = !bound_predicates.empty();
//     bdd simple_disjunction = edge_cond;
//     bool is_simple_conjunction = false;

//     // Separate constraints and goals based on start state
//     vector<pddlboat::ExpressionPtr> constraints;
//     vector<pddlboat::ExpressionPtr> required_goals;
//     pddlboat::DomainPtr domain = domain_->getPddlboatDomainPtr();

//     // Step 2: Split into constraints and goals if there are required predicates
//     if (has_required_predicates) {
//         split_constraints_and_goals(bound_predicates, start_state->getPddlboatStatePtr(), constraints, required_goals);

//         // Step 3: Simplify the edge condition using bdd_restrict
//         simple_disjunction = bdd_restrict(edge_cond, required_predicates_bdd);

//         // Step 4: Check if the simplified condition is a simple conjunction
//         is_simple_conjunction = (simple_disjunction == bddtrue);
//     }

//     // Step 6: Create goals for the subproblem
//     vector<pddlboat::ExpressionPtr> goals = required_goals;
//     if (!is_simple_conjunction) {
//         // Handle the disjunction case
//         vector<pddlboat::ExpressionPtr> disjunct_goals;
//         create_disjunct_goals(simple_disjunction, disjunct_goals);
//         pddlboat::ExpressionPtr disjunct_goals_expr = pddlboat::makeOr(disjunct_goals);
//         // static_pointer_cast<pddlboat::Expression>(predicate)
//         pddlboat::ExpressionPtr start_state_expr = static_pointer_cast<pddlboat::Expression>(start_state->getPddlboatStatePtr()->toExpression());
//         // cout << "Start state expression: " << endl;
//         // start_state_expr->toPDDL(cout);
//         // cout << endl << "Disjunctive goal: " << endl;
//         // disjunct_goals_expr->toPDDL(cout);
//         // cout << endl;
//         if (state_satisfies_expression(start_state, disjunct_goals_expr)) {
//             // cout << "disjunct_goals_expr is true in a start state" <<endl;
//             // Add it to constraints.
//             constraints.push_back(disjunct_goals_expr);
//         } 
//         // Update goals with disjunctive condition.
//         goals.push_back(disjunct_goals_expr);
//     }

//     if (!constraints.empty()) {
//         // Create a conjunction of all constraints
//         auto constraints_expr = pddlboat::makeAnd(constraints);
//         domain = get_domain_with_constraints(constraints_expr, domain);
//     }

//     // Step 7: Create the final goal as a conjunction of all goals
//     auto final_goal = pddlboat::makeAnd(goals);

//     // Step 8: Use the new domain to create a new subproblem
//     auto subproblem = make_shared<pddlboat::Problem>(pddlProblem_->name, domain);
//     subproblem->objects = pddlProblem_->objects;
//     subproblem->start = start_state->getPddlboatStatePtr();
//     subproblem->goal = final_goal;

//     return subproblem;
// }

// New version
    // Step 1: Create a goal for the subproblem 
    // Process bdd corresponding to edge condition for moving to the next DFA state.
    // 1) Collect required predicates -> turn into required_goals
    // 2) Separate "required predicates" to get a remaining "disjunct_conditions"
    // if "required predicates" is empty -> a "simple disjunction" case
    // if "remaining disjunction" is true -> a "simple conjunction" case
    // 3) Create a final_goal by conjuncting required_goals and disjunct_conditions

    // Step 2: Deal with constraints on intermediate states
    // Case 1: (edge_cond || self_edge_cond == bddtrue): self-edge is just a negation of edge condition
        // Do nothing! No constarints needed.
    // Case 2: self_edge_cond == bddfalse: no self edge!
        // find a plan of length 1 that achieves a state that satifies final_goal
    // Case 3: self_edge_cond is NOT satisfied in out_state
        // find a plan of length 1 that achieves a state that satifies final_goal || self_edge_goal
        // If satisfies final_goal, then we are done!
        // Else, remember the first action in a plan and go to Case 4 
    // Case 4: self_edge_cond is satisfied in out_state
        // Create a self_edge_constraint and include it in the domain

    // Step 3: Create subproblem with final_goal and a new "constrained" domain
vector<pair<shared_ptr<pddlboat::Plan::Step>, pddlboat::ProblemPtr>> PDDLProblem::create_subproblem(bdd& edge_cond, bdd& self_edge_cond, shared_ptr<PDDLState> curr_state) {
    // Get a raw pddlboat::StatePtr.
    auto curr_domain_state = curr_state->getPddlboatStatePtr();

    // Step 1: Create a goal for the subproblem
    auto final_goal = bdd_to_expression(edge_cond);

    // Step 2: Deal with constraints on intermediate states
    vector<pair<shared_ptr<pddlboat::Plan::Step>, pddlboat::ProblemPtr>> results;

    if (bdd_or(edge_cond, self_edge_cond) == bddtrue) {
        // Case 1: No constraints needed for self-edge
        // cout << "Case 1: No constraints needed for self-edge" << endl;
        auto subproblem = instantiate_subproblem(curr_domain_state, final_goal);
        // Single entry in results with no action prefix
        results.emplace_back(nullptr, subproblem);
    } else if (self_edge_cond == bddfalse) {
        // Case 2: No self-edge
        // cout << "Case 2: No self-edge" << endl;
        // cout << "No self edge detected! Finding a plan of length 1..." << endl;
        // Plan to reach the final_goal in a single step
        auto single_steps = plan_single_step_to_goal(curr_domain_state, final_goal);
        if (single_steps.empty()) {
            // std::cerr << "Error: Failed to find a single-step plan to reach the final goal." << std::endl;
            return {};
        }
        // cout << "Potential steps: " << endl;
        for (auto& step : single_steps) {
            results.emplace_back(step, nullptr);
            // step->toString(std::cout) << endl;
        }
    } else {
        auto self_edge_expr = bdd_to_expression(self_edge_cond);
        if (!state_satisfies_expression(curr_domain_state, self_edge_expr)) {
            // Case 3: Self-edge condition is NOT satisfied in curr_state
            // cout << "Case 3: Self-edge condition is NOT satisfied in curr_state" << endl;
            auto extended_goal = pddlboat::makeOr({final_goal, self_edge_expr});
            // cout << "Self-edge condition not satisfied in current state! Finding a plan of length 1..." << endl;

            auto single_steps = plan_single_step_to_goal(curr_domain_state, extended_goal);
            if (single_steps.empty()) {
                // std::cerr << "Error: Failed to find a single-step plan to reach the extended goal." << std::endl;
                return {};
            }
            // cout << "Potential steps: " << endl;
            for (auto& step : single_steps) {
                // step->toString(std::cout) << endl;
                auto next_state = step->state;
                if (state_satisfies_expression(next_state, final_goal)) {
                    // No need for a subproblem; the goal is already achieved
                    results.emplace_back(step, nullptr);
                } else if (state_satisfies_expression(next_state, self_edge_expr)) {
                    // Converted to Case 4: Create a subproblem with self-edge constraints
                    auto subproblem = instantiate_subproblem(next_state, final_goal, self_edge_expr);
                    results.emplace_back(step, subproblem);
                }
            }
        } else {
            // Case 4: Self-edge condition is satisfied in curr_state
            // cout << "Case 4: Self-edge condition is satisfied in curr_state" << endl;
            auto subproblem = instantiate_subproblem(curr_domain_state, final_goal, self_edge_expr);
            results.emplace_back(nullptr, subproblem);
        }
    }
    return results;
}

pddlboat::ExpressionPtr PDDLProblem::bdd_to_expression(bdd& edge_cond) {
    // Step 1: Collect required predicates (conjuncts) from the BDD
    bdd required_predicates_bdd;
    auto required_predicates = collect_bound_predicates(edge_cond, required_predicates_bdd);

    // Step 2: Separate disjunctive conditions
    bdd disjunct_conditions = edge_cond;
    if (!required_predicates.empty()) {
        // Move required conjuncts outside of disjunction
        disjunct_conditions = bdd_restrict(edge_cond, required_predicates_bdd);
    }

    // Step 3: Determine if the edge condition is a simple conjunction
    bool is_simple_conjunction = (disjunct_conditions == bddtrue);

    // Step 4: Convert required predicates into goals (ANDed)
    vector<pddlboat::ExpressionPtr> final_goal_expressions;
    get_goals(required_predicates, final_goal_expressions);

    // Step 5: Handle disjunctive conditions (if any)
    if (!is_simple_conjunction) {
        vector<pddlboat::ExpressionPtr> disjunct_goals;
        create_disjunct_goals(disjunct_conditions, disjunct_goals);
        auto disjunctive_expr = pddlboat::makeOr(disjunct_goals);
        final_goal_expressions.push_back(disjunctive_expr);
    }

    // Step 6: Combine all expressions into a single AND expression
    return pddlboat::makeAnd(final_goal_expressions);
}

bool PDDLProblem::state_satisfies_expression(pddlboat::StatePtr state, pddlboat::ExpressionPtr expr) {
    // Evaluate the expression against the state's PDDL representation
    return expr->evaluate(state, {});
}

pddlboat::ProblemPtr PDDLProblem::instantiate_subproblem(
    pddlboat::StatePtr start_state, 
    pddlboat::ExpressionPtr goal, 
    pddlboat::ExpressionPtr constraint_expr
) {
    // cout << "Instantiating a subproblem with the following goal: " << endl;
    // goal->toPDDL(std::cout) << std::endl;
    // If a constraint is provided, create a constrained domain
    pddlboat::DomainPtr used_domain = domain_->getPddlboatDomainPtr();
    if (constraint_expr) {
        // cout << " and these constraints: " << endl;
        // constraint_expr->toPDDL(std::cout) << std::endl;
        used_domain = get_domain_with_constraints(constraint_expr, used_domain);
    }

    // Instantiate the subproblem
    auto subproblem = make_shared<pddlboat::Problem>("subproblem", used_domain);
    subproblem->objects = pddlProblem_->objects;
    subproblem->start = start_state;
    subproblem->goal = goal;

    return subproblem;
}


vector<shared_ptr<pddlboat::Plan::Step>> 
PDDLProblem::plan_single_step_to_goal(pddlboat::StatePtr curr_domain_state, pddlboat::ExpressionPtr goal) {
    vector<shared_ptr<pddlboat::Plan::Step>> steps;

    // Iterate over all non-grounded actions in the domain
    for (const auto& action : domain_->getActions()) {
        // Get the list of parameters for the current action
        auto actionParams = action->getParameters();

        // Iterate over all possible groundings for the action
        for (const auto& assignment : pddlProblem_->getGroundings(actionParams)) {
            // Check if the action's preconditions hold in the current state
            if (action->checkPreconditions(curr_domain_state, assignment)) {
                // Clone the current state to apply the effect
                auto next_domain_state = curr_domain_state->clone();

                // Apply the action effect
                if (action->applyEffect(next_domain_state, curr_domain_state, assignment)) {
                    if (state_satisfies_expression(next_domain_state, goal)) {
                        // Create a Plan::Step for the action
                        auto step = make_shared<pddlboat::Plan::Step>(
                            action->getPddlboatActionPtr(), // Action
                            assignment                      // Assignment
                        );
                        step->prior = curr_domain_state; // State before action
                        step->state = next_domain_state; // State after action

                        steps.push_back(step);
                    }
                }
            }
        }
    }
    return steps;
}


void PDDLProblem::create_disjunct_goals(bdd& simple_disjunction, vector<pddlboat::ExpressionPtr>& disjunct_goals) {
    map<pddlboat::PredicatePtr, bdd> predicate_to_bdd;
    // Step 1: Collect all disjunct predicates from the BDD
    auto disjunct_predicates = collect_bound_predicates_in_OR(simple_disjunction, predicate_to_bdd);

    // Step 2: Extract the predicates into a vector for easier subset iteration
    vector<pair<pddlboat::PredicatePtr, bool>> predicate_list(disjunct_predicates.begin(), disjunct_predicates.end());
    size_t num_predicates = predicate_list.size();

    // Step 3: Track minimal subsets
    set<size_t> covered_masks;

    // Step 4: Iterate over all possible subsets of disjunct_predicates
    for (size_t subset_mask = 1; subset_mask < static_cast<size_t>(1 << num_predicates); ++subset_mask) {
        // Skip this subset if any smaller subset already covers it
        bool skip = false;
        for (size_t smaller_mask : covered_masks) {
            // Check if subset_mask is a superset of smaller_mask
            if ((subset_mask & smaller_mask) == smaller_mask) {
                skip = true;
                break;
            }
        }
        if (skip) continue;

        // Step 5: Create a BDD conjunction for the current subset
        bdd subset_bdd = bddtrue;
        vector<pddlboat::ExpressionPtr> subset_expressions;

        for (size_t j = 0; j < num_predicates; ++j) {
            // Check if the j-th element is in the subset
            if (subset_mask & (1 << j)) {
                auto predicate = predicate_list[j].first;
                bool is_positive = predicate_list[j].second;

                // Use the memorized BDD variable
                bdd var_bdd = predicate_to_bdd[predicate]; 
                subset_bdd &= var_bdd;

                // Create the corresponding expression
                pddlboat::ExpressionPtr expr = is_positive ? static_pointer_cast<pddlboat::Expression>(predicate) : pddlboat::makeNot(predicate);

                subset_expressions.push_back(expr);
            }
        }

        // Step 6: Restrict the simple_disjunction BDD with the subset BDD
        if (bdd_restrict(simple_disjunction, subset_bdd) == bddtrue) {
            // If the restricted BDD is true, this subset represents a valid part of the DNF formula
            auto subset_conjunction = pddlboat::makeAnd(subset_expressions);
            disjunct_goals.push_back(subset_conjunction);

            // Mark this subset as covered
            covered_masks.insert(subset_mask);
        }
    }
}

pddlboat::PredicatePtr PDDLProblem::extract_predicate_from_ap_name(const std::string& ap_name) {
    // Split the atomic proposition name by "_"
    vector<string> tokens;
    size_t start = 0, end = 0;
    while ((end = ap_name.find('_', start)) != string::npos) {
        tokens.push_back(ap_name.substr(start, end - start));
        start = end + 1;
    }
    tokens.push_back(ap_name.substr(start));

    if (tokens.size() < 2) {
        cerr << "Invalid AP name format: " << ap_name << endl;
        return nullptr;  // Return null if the format is invalid
    }

    string predicate_name = tokens.at(0);
    auto predicate_it = pddlProblem_->domain->predicates.find(predicate_name);
    auto last_valid_predicate_it = predicate_it;
    size_t last_valid_token_num = 0;

    // This loop tries to progressively add tokens to find a valid predicate
    for (size_t token_num = 1; token_num < tokens.size(); ++token_num) {
        predicate_name = predicate_name + name_connector_ + tokens.at(token_num);
        predicate_it = pddlProblem_->domain->predicates.find(predicate_name);
        if (predicate_it != pddlProblem_->domain->predicates.end()) {
            last_valid_predicate_it = predicate_it;
            last_valid_token_num = token_num;
        }
    }

    if (last_valid_predicate_it == pddlProblem_->domain->predicates.end()) {
        cerr << "Predicate not found for AP: " << ap_name << endl;
        return nullptr;  // Return null if the predicate is not found
    }

    auto p_predicate = last_valid_predicate_it->second;

    vector<string> bindings(tokens.begin() + last_valid_token_num + 1, tokens.end());
    return p_predicate->bind(bindings, pddlProblem_);  // Return the bound predicate
}

map<pddlboat::PredicatePtr, bool> PDDLProblem::collect_bound_predicates(bdd& edge_cond, bdd& conjunction_bdd) {
    // Initialize the conjunction BDD to true
    conjunction_bdd = bddtrue;
    // Map to collect bound predicates (from PredicatePtrs to booleans)
    map<pddlboat::PredicatePtr, bool> bound_predicates;

    // cout << "Printing predicates" << endl;
    // for (const auto& pred_pair : pddlProblem_->domain->predicates) {
    //     cout << pred_pair.first << endl;
    // }
    // cout << "=====" << endl;

    for (const auto& [var_num, ap_name] : domain_manager_->get_bdd_to_ap_map()) {
        bdd p = bdd_ithvar(var_num);  // Represents the atomic proposition 'p'
        bdd np = bdd_nithvar(var_num); // Represents the negation of 'p'

        // Compute BDD restrictions (XOR)
        bool contains_pos = (bdd_restrict(edge_cond, np) == bddfalse);
        bool contains_neg = (bdd_restrict(edge_cond, p) == bddfalse);

        if (!contains_pos && !contains_neg) {
            continue; // Neither condition affects the result
        }

        // Bind the predicate
        auto predicate = extract_predicate_from_ap_name(ap_name);

        if (predicate == nullptr) {
            cerr << "Predicate not found for AP: " << ap_name << endl;
            continue;
        }

        // Set boolean value based on the presence of positive or negative conditions
        bound_predicates[predicate] = contains_pos;
        // Update the conjunction BDD
        if (contains_pos) {
            // Add the positive condition to the conjunction
            conjunction_bdd &= p;
        } else {
            // Add the negated condition to the conjunction
            conjunction_bdd &= np;
        }
        // cout << "Added a conjunct bounded predicate: ";
        // if (!contains_pos) cout << "not ";
        // predicate->toPDDL(cout) << endl;
    }
    return bound_predicates;
}

map<pddlboat::PredicatePtr, bool> PDDLProblem::collect_bound_predicates_in_OR(bdd& edge_cond, map<pddlboat::PredicatePtr, bdd>& predicate_to_bdd) {
    // Map to collect bound predicates (from PredicatePtrs to booleans)
    map<pddlboat::PredicatePtr, bool> bound_predicates;

    // Iterate over the keys of the bdd_to_ap_ map to get the relevant variable numbers
    for (const auto& [var_num, ap_name] : domain_manager_->get_bdd_to_ap_map()) {
        bdd p = bdd_ithvar(var_num);  // Represents the atomic proposition 'p'
        bdd np = bdd_nithvar(var_num); // Represents the negation of 'p'

        // Check if this variable is part of the disjunction
        if (bdd_simplify(edge_cond, p) == edge_cond) {
            continue;  // Skip it.
        }
        // cout << "Processing variable number " << var_num << " with AP name: " << ap_name << endl;

        // Extract the predicate from the atomic proposition name
        auto predicate = extract_predicate_from_ap_name(ap_name);
        if (predicate == nullptr) {
            cerr << "Predicate not found for AP: " << ap_name << endl;
            continue;
        } 

        // Determine if the predicate is positive or negative
        bool is_positive = (bdd_restrict(bdd_not(edge_cond), p) == bddfalse);
        bound_predicates[predicate] = is_positive;

        // Memorize the corresponding BDD variable (p or np)
        predicate_to_bdd[predicate] = is_positive ? p : np;

        // cout << "Added a disjunct bounded predicate: ";
        // if (!is_positive) cout << "not ";
        // predicate->toPDDL(cout) << endl;
    }

    return bound_predicates;
}

void PDDLProblem::get_goals(const map<pddlboat::PredicatePtr, bool>& bound_predicates, vector<pddlboat::ExpressionPtr>& goals) {
    for (const auto& pred_pair : bound_predicates) {
        // Get the predicate and its associated boolean value 
        // (true for positive, false for negated)
        auto predicate = pred_pair.first;
        bool is_positive = pred_pair.second;

        // Create a literal according to its sign.
        pddlboat::ExpressionPtr signed_predicate = predicate;
        if (!is_positive) {
            signed_predicate = pddlboat::makeNot(predicate);
        }

        // Add the predicate to the goals 
        // (since it's disjunction, no constraints here)
        goals.push_back(signed_predicate);
    }
}



void PDDLProblem::split_constraints_and_goals(
    const map<pddlboat::PredicatePtr, bool>& bound_predicates,
    const pddlboat::StatePtr& start_state,
    vector<pddlboat::ExpressionPtr>& constraints,
    vector<pddlboat::ExpressionPtr>& goals) {
    for (const auto& pred_pair : bound_predicates) {
        // Get the predicate and its associated boolean value 
        // (true for positive, false for negated)
        auto predicate = pred_pair.first;
        bool is_positive = pred_pair.second;

        // Create a literal according to its sign.
        pddlboat::ExpressionPtr signed_predicate = predicate; 
        // Negate the predicate if needed.
        if (!is_positive) {
            signed_predicate = pddlboat::makeNot(predicate);
        }

        // Check if the predicate (or its negation) is true in the start state.
        if (predicateHoldsInState(start_state, predicate) == is_positive) {
            // std::cout << "Predicate is satisfied in the start_state: ";
            // signed_predicate->toPDDL(std::cout) << std::endl;
            // The start state satisfies this predicate, so it's a constraint.
            constraints.push_back(signed_predicate);
        } 
        goals.push_back(signed_predicate);
    }
}

pddlboat::DomainPtr PDDLProblem::get_domain_with_constraints(pddlboat::ExpressionPtr constraints_expr, const pddlboat::DomainPtr& original_domain) {
    // Create a deep copy of the original domain
    pddlboat::DomainPtr domain = make_shared<pddlboat::Domain>(*original_domain);

    string constraint_predicate_name = "constraints";

    // Check if the derived predicate already exists
    if (domain->isDerivedPredicate(constraint_predicate_name)) {
        std::cerr << "ERROR: Derived predicate 'constraints' already exists in the domain." << std::endl;
        return original_domain;
    }

    // Add the derived predicate to the domain
    // No variables for the constraints predicate
    pddlboat::VariableList empty_vars;
    auto derived_predicate_definition = pddlboat::makeDerivedPred(constraint_predicate_name, empty_vars, constraints_expr);

    domain->addDerivedPredicate(derived_predicate_definition);

    // cout << "Added derived predicate: " << constraint_predicate_name << endl;

    // Clear all actions in the new domain.
    domain->actions.clear();

    // Update all action preconditions to include (constraints)
    for (const auto& action_pair : original_domain->actions) {
        auto original_action = action_pair.second;

        // Bind the 'constraints' predicate for precondition use
        auto constraint_predicate = derived_predicate_definition->bind();

        // Create a new precondition.
        auto updated_precondition = pddlboat::makeAnd({original_action->precondition, constraint_predicate});

        // Create a new action with the updated precondition
        auto new_action = pddlboat::makeAction(
            original_action->name, 
            original_action->parameters, 
            updated_precondition, 
            original_action->effect
        );

        // Add the new action to the copied domain
        domain->addAction(new_action);
    }
    return domain;
}

bool PDDLProblem::predicateHoldsInState(const pddlboat::StatePtr& state, const pddlboat::PredicatePtr& predicate) {
    // Retrieve the predicate name and arguments from the predicate object.
    string predicate_name = predicate->name();

    // Get the arguments (bindings) of the predicate
    vector<string> args;
    for (const auto &binding : predicate->bindings) {
        args.push_back(binding.name); 
    }
    // Check if the predicate is true in the state
    return state->isTrue(predicate_name, args);
}


void PDDLProblem::print_bdd(bdd& expr) {
    cout << "Printing bdd = " << expr << endl;
    for (const auto& [var_num, ap_name] : domain_manager_->get_bdd_to_ap_map()) {
        bdd p = bdd_ithvar(var_num);  // Represents the atomic proposition 'p'
        bdd np = bdd_nithvar(var_num); // Represents the negation of 'p'
        if ((bdd_restrict(expr, np) != bddfalse) && (bdd_restrict(expr, p) != bddfalse)) {
            // cout << "Continue: var not there" << endl;
            continue;
        }

        // Check if including the proposition (or its negation) makes a difference in the XOR result
        if (bdd_restrict(expr, np) == bddfalse) {
            // Condition contains positive p
            std::cout << "(" << ap_name << "), ";

        } else if (bdd_restrict(expr, p) == bddfalse) {
            // Condition contains negative p: an obstacle
            std::cout << "(not " << ap_name << "), ";
        }
    }
}

void PDDLProblem::write_solution_to_file(const string& file_path) const {
    // Open the file
    std::ofstream ofs(file_path);

    // Check if the file is open
    if (!ofs.is_open()) {
        std::cerr << "ERROR: failed to open file: " << file_path << std::endl;
        return;
    }
    // Write the plan = a sequence of actions.
    ofs << "Plan:" << std::endl;
    for (const auto& ps : product_path_) {
        if (auto next_step = ps.get_step()) {
            next_step->toString(ofs) << std::endl;
        }
    }
    ofs << std::endl;
    // Write the DFA path to the file
    ofs << "DFA Path:" << std::endl;
    if (!dfa_path_.empty()) {
        ofs << dfa_path_.front();
        for (auto it = std::next(dfa_path_.begin()); it != dfa_path_.end(); ++it) {
            ofs << " -> " << *it;
        }
    }
    ofs << std::endl << std::endl;

    // Write the product path to the file
    ofs << "Product Path:" << std::endl;
    if (!product_path_.empty()) {
        ofs << product_path_.front();
        for (auto it = std::next(product_path_.begin()); it != product_path_.end(); ++it) {
            ofs << " -> " << *it;
        }
    }
    ofs << std::endl;

    // Close the file
    ofs.close();

    cout << "Solution written to " << file_path << endl;
}

string PDDLProblem::extract_problem_name(const string& path, const string& extension) {
    size_t lastSlashPos = path.find_last_of('/');
    size_t extensionPos = path.find(extension);

    if (lastSlashPos != std::string::npos && extensionPos != std::string::npos) {
        return path.substr(lastSlashPos + 1, extensionPos - lastSlashPos - 1);
    } else {
        std::cerr << "Invalid file path format: " << path << std::endl;
        return "problem"; // Default name in case of error
    }
}

string PDDLProblem::extract_domain_name(const string& path) {
    size_t lastSlashPos = path.find_last_of('/');
    // Extracting the domain name
    if (lastSlashPos != std::string::npos) {
        size_t secondLastSlashPos = path.find_last_of('/', lastSlashPos - 1);
        if (secondLastSlashPos != std::string::npos) {
            return path.substr(secondLastSlashPos + 1, lastSlashPos - secondLastSlashPos - 1);
        }
    }
    std::cerr << "Invalid file path format for domain name: " << path << std::endl;
    return "domain"; // Default name
}


void PDDLProblem::extract_names(const std::string& problemFile) {
    problem_name_ = extract_problem_name(problemFile);
    domain_name_ = extract_domain_name(problemFile);
}

// Helper function to validate the DFA trace
bool PDDLProblem::validate_dfa_trace(const vector<size_t>& dfa_trace) {
    if (dfa_trace.empty()) {
        cerr << "ERROR: the DFA trace is empty!" << endl;
        return false;
    } else if (dfa_trace.size() == 1) {
        cerr << "ERROR: the DFA trace is of size 1!" << endl;
        return false;
    }
    return true;
}

// Helper function to generate heuristics based on landmarks
int PDDLProblem::compute_heuristics(const ProductState& state, const map<size_t, DomainStateSet>& landmarks, size_t dfa_state) {
    if (landmarks.count(dfa_state)) {
        return state.compute_heuristic_cost(landmarks.at(dfa_state));
    }
    return 0;
}

// Helper function to handle wrong transitions
bool PDDLProblem::handle_wrong_transitions(size_t& curr_num_wrong_dfa_trans,
                                           shared_ptr<DFANode>& end_dfa_node, shared_ptr<DFANode>& next_dfa_node) {
    curr_num_wrong_dfa_trans++;
    if (curr_num_wrong_dfa_trans > max_num_wrong_dfa_trans_) {
        dfa_manager_->give_up_on_path(end_dfa_node, next_dfa_node);
        // cout << "Giving up on transition: " << next_dfa_node->getParent()->getState() << "=>" << next_dfa_node->getState() << endl;
        return false;  // Giving up on this trace.
    }
    return true;
}

// Helper function to push a new product state onto the corresponding queue
void PDDLProblem::enqueue_product_state(map<size_t, priority_queue<pair<int, ProductState>, vector<pair<int, ProductState>>, greater<pair<int, ProductState>>>>& regionQueues, const ProductState& state, int heuristic_cost, size_t dfa_state) {
    regionQueues[dfa_state].push(make_pair(heuristic_cost, state));
}

shared_ptr<pddlboat::Planner> PDDLProblem::get_task_planner(const pddlboat::ProblemPtr& subproblem) const {
    shared_ptr<pddlboat::Planner> task_planner;

    if (planner_type_ == "z3") {
        pddlboat::Z3Planner::Options options;
        options.dump_clauses = false;
        task_planner = make_shared<pddlboat::Z3Planner>(subproblem, options);

    } else if (planner_type_ == "fd") {
        pddlboat::FastDownwardPlanner::Options options;
        // Configure search type for Fast Downward planner
        if (search_type_ == "lazygreedy") {
            options.search = pddlboat::FastDownwardPlanner::LAZYGREEDY;
        } else if (search_type_ == "fdat") {
            options.search = pddlboat::FastDownwardPlanner::FDAT;
        } else if (search_type_ == "lama-full" || search_type_ == "lama") {
            options.search = pddlboat::FastDownwardPlanner::LAMA;
        } else if (search_type_ == "lama-first") {
            // options.search = pddlboat::FastDownwardPlanner::LAMA_FIRST;
            options.search = pddlboat::FastDownwardPlanner::LAMA_FIRST;
        } else {
            cerr << "Unknown search type: " << search_type_ << endl;
            exit(EXIT_FAILURE);
        }

        task_planner = make_shared<pddlboat::FastDownwardPlanner>(subproblem, options);

    } else if (planner_type_ == "astar") {
        // A* planner
        task_planner = make_shared<pddlboat::AStarPlanner>(subproblem);

    } else {
        cerr << "Unknown planner type: " << planner_type_ << endl;
        exit(EXIT_FAILURE);
    }

    return task_planner;
}

