#include "PDDLState.h"
#include "PDDLAction.h"

PDDLState::PDDLState(const pddlboat::StatePtr& state) 
    : pddlboatState_(state), isCached_(false) {}

void PDDLState::cache() {
    isCached_ = true;
}

bool PDDLState::isCached() const {
    return isCached_;
}


double PDDLState::distance(const DomainState& other) const {
    // Implement a distance metric between states if needed
    return 0.0; // Placeholder
}

bool PDDLState::operator==(const DomainState& other) const {
    try {
        const auto& otherPddlState = toPDDLState(other);
        return pddlboatState_->isEqual(otherPddlState.pddlboatState_);
    } catch (const std::bad_cast&) {
        return false;
    }
}

bool PDDLState::operator<(const DomainState& other) const {
    try {
        const auto& otherPddlState = toPDDLState(other);
        // Compare by hash.
        return pddlboatState_->hash() < otherPddlState.pddlboatState_->hash();
    } catch (const std::bad_cast&) {
        return false;
    }
}


std::ostream& PDDLState::print(std::ostream& os) const {
    // Print the state
    return pddlboatState_->toPDDL(os);
}

const PDDLState& PDDLState::toPDDLState(const DomainState& state) const {
    return dynamic_cast<const PDDLState&>(state);
}

pddlboat::StatePtr PDDLState::getPddlboatStatePtr() const {
    return pddlboatState_;
}

bool PDDLState::isActionApplicable(const std::shared_ptr<PDDLAction>& action) const {
    if (action->isGrounded()) {
        // If the action is already grounded, directly check its preconditions
        return action->checkPreconditions(pddlboatState_, action->getAssignment());
    } else {
        // For non-grounded actions, iterate over possible groundings and check
        for (const auto& assignment : action->getPddlboatActionPtr()->domain->getGroundings(action->getPddlboatActionPtr()->parameters)) {
            if (action->checkPreconditions(pddlboatState_, assignment)) {
                return true;
            }
        }
        return false;
    }
}

std::shared_ptr<PDDLState> PDDLState::applyAction(const std::shared_ptr<PDDLAction>& action) const {
    // Clone the current state to apply effects
    auto newState = std::make_shared<pddlboat::State>(pddlboatState_->clone());

    if (action->isGrounded()) {
        // Apply the grounded action
        if (action->applyEffect(newState, pddlboatState_, action->getAssignment())) {
            return std::make_shared<PDDLState>(newState);
        }
    } else {
        // For non-grounded actions, iterate over possible groundings and apply
        for (const auto& assignment : action->getPddlboatActionPtr()->domain->getGroundings(action->getPddlboatActionPtr()->parameters)) {
            if (action->checkPreconditions(pddlboatState_, assignment) &&
                action->applyEffect(newState, pddlboatState_, assignment)) {
                return std::make_shared<PDDLState>(newState);
            }
        }
    }

    // Return nullptr if the action could not be applied
    return nullptr;
}


