#ifndef PDDL_PROBLEM_H
#define PDDL_PROBLEM_H

#include "PDDLDomain.h" 
#include "DomainState.h"
#include "ProductState.h"
#include "ProductTransition.h"
#include "LTLFormula.h"
#include "DFANode.h"
#include "DFAManager.h"
#include "DomainManager.h"
#include "ProductManager.h"
#include "DFAManager.h"
#include "Constants.h"

#include <map>
#include <vector>
#include <deque>
#include <queue>
#include <unordered_map>
#include <string>
#include <set>
#include <limits>
#include <stdexcept>
#include <thread>
#include <future>
#include <chrono>

#include <pddlboat/solver/planner.hpp>
#include <pddlboat/solver/fdplanner.hpp>
#include <pddlboat/solver/ffplanner.hpp>
#include <pddlboat/solver/symkplanner.hpp>
#include <pddlboat/solver/z3planner.hpp>
#include <pddlboat/solver/astarplanner.hpp>

using namespace std;

class PDDLProblem {
public:
    PDDLProblem(
    const string& problemFile,
    shared_ptr<PDDLDomain> domainPtr,
    const string& planner_type,
    const string& search_type = {},
    const string& name_connector = "-",
    bool cache = false,
    bool feedback = false,
    bool use_landmarks = false,
    bool hamming_dist = false,
    bool save_dfa = false,
    size_t subproblem_timeout = 60000,
    int backtracks_limit = std::numeric_limits<int>::max(),
    size_t max_num_wrong_dfa_trans = 300
);
    ~PDDLProblem();

    // Method to get the wrapped pddlboat::Problem
    const pddlboat::ProblemPtr& getPddlboatProblemPtr() const;
    vector<ProductState> solve();
    vector<shared_ptr<DomainState>> get_domain_path() const;
    vector<size_t> get_dfa_path() const;

    string get_filename() const;
    double get_dfa_construction_time() const;
    size_t get_num_expanded_nodes() const;
    size_t get_num_generated_nodes() const;
    size_t get_num_of_backtracks() const;
    size_t get_plan_length() const;
    map<string, pair<string, vector<string>>> get_pred_mapping() const;

    void print_product_path() const;
    void print_domain_path() const;
    void print_dfa_path() const;

    static string extract_problem_name(const string &path, const string &extension = ".pddl");
    static string extract_domain_name(const string &path);

    void write_solution_to_file(const string& file_path) const;
    static pddlboat::ProblemPtr parseProblem(const std::string& problemFile, const pddlboat::DomainPtr& domainPtr);

private:
    void extract_names(const string &problemFile);
    void save_paths();
    void realize_dfa_trace(shared_ptr<DFANode>& end_trace_node);
    void realize_dfa_trace_manually(shared_ptr<DFANode>& end_trace_node);
    void realize_dfa_trace_with_planner(shared_ptr<DFANode>& end_trace_node);
    vector<pair<shared_ptr<pddlboat::Plan::Step>, pddlboat::ProblemPtr>> create_subproblem(bdd& edge_cond, bdd& self_edge_cond, shared_ptr<PDDLState> curr_state);
    pddlboat::PredicatePtr extract_predicate_from_ap_name(const std::string& ap_name);
    map<pddlboat::PredicatePtr, bool> collect_bound_predicates(bdd& edge_cond, bdd& conjunction_bdd);
    map<pddlboat::PredicatePtr, bool> collect_bound_predicates_in_OR(bdd& edge_cond, map<pddlboat::PredicatePtr, bdd>& predicate_to_bdd);
    void split_constraints_and_goals(
    const map<pddlboat::PredicatePtr, bool>& bound_predicates,
    const pddlboat::StatePtr& curr_state,
    vector<pddlboat::ExpressionPtr>& constraints,
    vector<pddlboat::ExpressionPtr>& goals);
    void get_goals(const map<pddlboat::PredicatePtr, bool>& bound_predicates,
    vector<pddlboat::ExpressionPtr>& goals);
    pddlboat::DomainPtr get_domain_with_constraints(pddlboat::ExpressionPtr constraints_expr, const pddlboat::DomainPtr& original_domain);
    bool predicateHoldsInState(const pddlboat::StatePtr& state, const pddlboat::PredicatePtr& predicate);
    void print_bdd(bdd& expr);

    vector<ProductState> construct_path(const map<ProductState, vector<ProductState>>& parent_map, ProductState target_state, bool cached=false);

    void cache_prefixes(const map<ProductState, vector<ProductState>>& parent_map, ProductState current_state, const vector<size_t>& dfa_trace, size_t min_prefix_length, size_t max_prefix_length);
    void enqueue_product_state(map<size_t, priority_queue<pair<int, ProductState>, vector<pair<int, ProductState>>, greater<pair<int, ProductState>>>>& regionQueues, 
    const ProductState& state, int heuristic_cost, size_t dfa_state);
    bool validate_dfa_trace(const vector<size_t>& dfa_trace);
    int compute_heuristics(const ProductState& state, const map<size_t, DomainStateSet>& landmarks, size_t dfa_state);
    bool handle_wrong_transitions(size_t& curr_num_wrong_dfa_trans,
    shared_ptr<DFANode>& current_dfa_node, shared_ptr<DFANode>& next_dfa_node);
    shared_ptr<pddlboat::Planner> get_task_planner(const pddlboat::ProblemPtr& subproblem) const;

    void constructDFAWithPromise(std::shared_ptr<DFAManager> dfa_manager, LTLFormula formula, std::promise<void> dfa_promise);

    void create_disjunct_goals(bdd& simple_disjunction, vector<pddlboat::ExpressionPtr>& disjunct_goals);

    vector<shared_ptr<pddlboat::Plan::Step>> plan_single_step_to_goal(pddlboat::StatePtr curr_domain_state, pddlboat::ExpressionPtr goal);

    pddlboat::ProblemPtr instantiate_subproblem(
    pddlboat::StatePtr start_state, 
    pddlboat::ExpressionPtr goal, 
    pddlboat::ExpressionPtr constraint_expr = nullptr);

    pddlboat::ExpressionPtr bdd_to_expression(bdd& edge_cond);
    bool state_satisfies_expression(pddlboat::StatePtr state, pddlboat::ExpressionPtr expr);

    pddlboat::ProblemPtr pddlProblem_;
    LTLFormula formula_;
    shared_ptr<PDDLDomain> domain_;
    shared_ptr<PDDLState> start_domain_state_;

    string planner_type_;
    string search_type_;
    string name_connector_;
    bool cache_;
    bool feedback_;
    bool use_landmarks_;
    bool hamming_dist_;
    bool save_dfa_;
    
    // DFA corresponding to LTL formula.
    spot::bdd_dict_ptr bdd_dict_;

    std::shared_ptr<DomainManager> domain_manager_;
    std::shared_ptr<DFAManager> dfa_manager_;
    std::shared_ptr<ProductManager> product_manager_;

    // Solution path (if found).
    vector<ProductState> product_path_;
    vector<shared_ptr<DomainState>> domain_path_;
    vector<size_t> dfa_path_;

    string filename_;
    string problem_name_;
    string domain_name_;
    chrono::duration<double> dfa_construction_time_;
    size_t num_expanded_nodes_;
    size_t subproblem_timeout_;
    int num_of_backtracks_;
    int backtracks_limit_;
    size_t max_num_wrong_dfa_trans_;

    // Cache map: stores DFA trace prefixes to corresponding solution paths.
    map<vector<size_t>, vector<ProductState>> dfa_trace_cache_;
};

#endif // PDDL_PROBLEM_H