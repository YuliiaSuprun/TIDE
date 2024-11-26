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
        std::ostringstream thisStateStream, otherStateStream;
        this->pddlboatState_->toPDDL(thisStateStream);
        otherPddlState.pddlboatState_->toPDDL(otherStateStream);
        return thisStateStream.str() < otherStateStream.str();
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


