#ifndef PRODUCT_STATE_H
#define PRODUCT_STATE_H

#include <iostream>
#include <ostream>
#include <pddlboat/solver/planner.hpp> // needed for Plan::Step
#include "DomainState.h"
#include "PDDLState.h"
#include "Action.h"

class ProductState {
public:

    ProductState(size_t dfa_state)
    : domain_state_(nullptr), dfa_state_(dfa_state), step_(nullptr), heuristic_cost_(INT_MAX) {}

    ProductState(const std::shared_ptr<DomainState> domain_state, size_t dfa_state, std::shared_ptr<pddlboat::Plan::Step> step = nullptr)
    : domain_state_(domain_state), dfa_state_(dfa_state), step_(step), heuristic_cost_(INT_MAX) {}

    // Accessor methods
    std::shared_ptr<DomainState> get_domain_state() const {
        return domain_state_;
    }

    std::shared_ptr<PDDLState> getPDDLState() {
        return std::static_pointer_cast<PDDLState>(domain_state_);
    }


    size_t get_dfa_state() const {
        return dfa_state_;
    }

    std::shared_ptr<pddlboat::Plan::Step> get_step() const {
        return step_;
    }

    bool isCached() const { 
        return domain_state_->isCached();
    }

    void cache() { 
        domain_state_->cache();  
    }

    double distance(const ProductState& other) const {
        return domain_state_->distance(*other.domain_state_);
    }

    int compute_heuristic_cost(const DomainStateSet& landmarks) const {
        if (heuristic_cost_ != INT_MAX) {
            // Has been already computed
            return heuristic_cost_;
        }
        for (const auto& landmark_state : landmarks) {
            int currentDistance = domain_state_->distance(*landmark_state);
            if (currentDistance < heuristic_cost_) {
                heuristic_cost_ = currentDistance;
            }
        }
        return heuristic_cost_;
    }

    bool operator==(const ProductState& other) const {
        return *domain_state_ == *(other.domain_state_) && dfa_state_ == other.dfa_state_;
    }

    // Need it for set.
    bool operator<(const ProductState& other) const {
        if (*domain_state_ < *other.domain_state_) {
            return true;
        } else if (*domain_state_ == *other.domain_state_ && dfa_state_ < other.dfa_state_) {
            return true;
        }
        return false;
    }

    friend std::ostream& operator<<(std::ostream& os, const ProductState& ps);

private:
    std::shared_ptr<DomainState> domain_state_;
    size_t dfa_state_;
    std::shared_ptr<pddlboat::Plan::Step> step_;  // a plan step that led to this state
    mutable int heuristic_cost_;
};

inline std::ostream& operator<<(std::ostream& os, const ProductState& ps) {
    os << "(" << *ps.get_domain_state() << ", DFA: " << ps.get_dfa_state() << ")";
    return os;
}

#endif // PRODUCT_STATE_H
