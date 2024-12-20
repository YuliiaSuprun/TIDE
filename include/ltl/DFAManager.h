#ifndef DFAUTILITY_H
#define DFAUTILITY_H

#include <memory>
#include <string>

#include <spot/tl/formula.hh>
#include <spot/twaalgos/dot.hh>
#include <spot/twaalgos/translate.hh>
#include <spot/twaalgos/totgba.hh>
#include <spot/twaalgos/hoa.hh>
#include <spot/twaalgos/remprop.hh>
#include <spot/twaalgos/postproc.hh> 
#include <spot/twaalgos/sccfilter.hh>
#include <spot/twa/bddprint.hh>
#include <spot/tl/ltlf.hh>
#include <spot/twa/twagraph.hh>

#include <bddx.h>

#include "LTLFormula.h"
#include "DFANode.h"
#include "DomainManager.h"

class DFAManager {
public:
    // Constructor
    DFAManager(shared_ptr<spot::bdd_dict> bddDict, set<bdd, BddComparator> equivalence_regions, bool feedback, bool hamming_dist=false);

    DFAManager(shared_ptr<spot::bdd_dict> bddDict, bool feedback, bool hamming_dist=false);

    // Convert LTL formula to DFA
    void construct_dfa(const LTLFormula& formula);

    // Save DFA to DOT and PNG files
    void save_dfa(const string& filename, const string& subdirname="");

    void print_dfa();

    size_t get_num_states() const;
    size_t get_start_state() const;
    spot::internal::state_out<spot::digraph<spot::twa_graph_state, spot::twa_graph_edge_data>> get_transitions(size_t state) const;
    bool is_accepting_state(size_t state) const;

    bdd get_edge_cond(size_t curr_dfa_state, size_t next_dfa_state) const;
    bdd get_self_edge_cond(size_t dfa_state) const;

    shared_ptr<DFANode> generate_dfa_path();

    int dfa_transition_cost(size_t from_state, size_t to_state);
    int dfa_transition_cost(size_t from_state, size_t to_state,
    const bdd& self_edge_cond, const bdd& trans_edge_cond);

    void update_dfa_transition_cost(shared_ptr<DFANode>& node, int cost);
    void update_dfa_transition_cost(size_t dfaStateOut, size_t dfaStateIn, int cost);

    void print_dfa_path(vector<size_t> dfa_path) const;
    void print_node_priority_queue();

    void initialize_node_priority_queue();

    bool is_transition_feasible(const bdd& edge_cond);

    bool is_transition_valid(const bdd& edge_cond, const bdd& next_state_bdd);
    spot::twa_graph::edge_storage_t* find_transition(const bdd& next_state_bdd, size_t curr_dfa_state);

    void give_up_on_path(shared_ptr<DFANode>& endPathNode, shared_ptr<DFANode>& failureNode);

    void add_node_to_queue(shared_ptr<DFANode>& node);

private:

    spot::bdd_dict_ptr bdd_dict_;
    set<bdd, BddComparator> equivalence_regions_;
    bool feedback_;
    bool hamming_dist_;

    // DFA corresponding to LTL formula.
    shared_ptr<spot::twa_graph> dfa_;

    // A priority queue with a pair of (cost, DFANode)
    NodeHeap nodePriorityQueue_;

    // Map to store the handles to the entries in the priority queue.
    // We need them to modify the keys in the queue depending on feedback.
    map<shared_ptr<DFANode>, NodeHeap::handle_type> node_handles_;

    // Map to store the cost of transitions
    map<pair<size_t, size_t>, int> dfa_transition_costs_;

    // Use for PDDL problems.
    bool use_pred_mapping_;

    int count_differing_aps(const bdd& bdd1, const bdd& bdd2);
};

#endif // DFAUTILITY_H
