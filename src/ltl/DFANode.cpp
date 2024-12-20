#include "DFANode.h"

DFANode::DFANode(size_t state, bdd selfEdgeCondition, std::shared_ptr<DFANode> parent, bdd parentEdgeCondition, int parent_edge_cost)
    : dfa_state_(state), parent_(parent),
    parent_edge_cost_(parent_edge_cost),
    parent_edge_condition_(parentEdgeCondition),
    self_edge_condition_(selfEdgeCondition),
    reachable_(true) {
        if (!parent) {
            // This is a root node (initial dfa state).
            // The path cost is initialized to 0.
            parent_edge_cost_ = 0;
            path_from_root_cost_ = 0;
            path_length_ = 0;
        } else {
            // This not the root node.
            // Compute the path effort score "recursively"
            path_from_root_cost_ = parent_edge_cost_ + parent->path_from_root_cost_;
            // Compute the path length "recursively"
            path_length_ = parent->path_length_ + 1;
        }
    }

size_t DFANode::getState() const {
    return dfa_state_;
}

std::shared_ptr<DFANode> DFANode::getParent() const {
    return parent_; 
}

const std::vector<std::weak_ptr<DFANode>>& DFANode::getChildren() const {
    return children_;  // Children are weak_ptr
}

int DFANode::getParentEdgeCost() const {
    return parent_edge_cost_;
}

int DFANode::getPathCost() const {
    return path_from_root_cost_;
}

int DFANode::getPathLength() const {
    return path_length_;
}

double DFANode::getPathDensity() const {
    if (path_length_ == 0) {
        // Root.
        return 0;
    }
    return static_cast<double>(path_from_root_cost_) / path_length_;
    // return static_cast<double>(path_from_root_cost_);
    // return static_cast<double>(path_from_root_cost_) / std::pow(path_length_, 2);
}

bdd& DFANode::getSelfEdgeCondition() {
    return self_edge_condition_;
}

bdd& DFANode::getParentEdgeCondition() {
    return parent_edge_condition_;
}

bool DFANode::isReachable() {
    return reachable_;
}

void DFANode::addChild(std::shared_ptr<DFANode> child) {
    children_.push_back(child);
}

void DFANode::setSelfEdgeCondition(const bdd& condition) {
    self_edge_condition_ = condition;
}

void DFANode::setParentEdgeCondition(const bdd& condition) {
    parent_edge_condition_ = condition;
}

std::vector<size_t> DFANode::getPathFromRoot() const {
    std::vector<size_t> path;
    for (auto node = shared_from_this(); node != nullptr; node = node->getParent()) {
        path.push_back(node->getState());
    }
    std::reverse(path.begin(), path.end());
    return path;
}

std::vector<std::shared_ptr<DFANode>> DFANode::getNodePathFromRoot() {
    std::vector<std::shared_ptr<DFANode>> nodePath;
    for (auto node = shared_from_this(); node != nullptr; node = node->getParent()) {
        nodePath.push_back(node);
    }
    std::reverse(nodePath.begin(), nodePath.end());
    return nodePath;
}

bool DFANode::repeated_edge(size_t next_dfa_state) {
    // Traverse up the path from the current node to the root, checking if any parent node
    // has the same DFA state as the next_dfa_state.
    for (auto node = shared_from_this(); node != nullptr; node = node->getParent()) {
        if (node->getState() == next_dfa_state) {
            // This means we have visited this DFA state before, hence it's a repeated edge.
            return true;
        }
    }
    // If the next_dfa_state is not found in the current path, it's not a repeated edge.
    return false;
}


bool DFANode::updateParentEdgeCost(int new_parent_edge_cost, const std::map<std::shared_ptr<DFANode>, NodeHeap::handle_type>& node_handles, NodeHeap& node_priority_queue) {

    if (new_parent_edge_cost == parent_edge_cost_) {
        // No changes are needed.
        return false;
    }

    // The scores are different: need to update all successors!
    int deltaScore = new_parent_edge_cost - parent_edge_cost_;
    parent_edge_cost_ = new_parent_edge_cost;

    if (parent_edge_cost_ == FAILURE_COST) {
        reachable_ = false;
    }

    std::queue<std::shared_ptr<DFANode>> queue;
    queue.push(shared_from_this());

    while (!queue.empty()) {
        auto currentNode = queue.front();
        queue.pop();

        // Update the path score of the current node
        currentNode->path_from_root_cost_ += deltaScore;
        // Propagate "reachability status" to successors.
        currentNode->reachable_ = reachable_;

        if (node_handles.count(currentNode) > 0) {
            // There is a path in the priority queue that ends on this node.
            auto handle = node_handles.at(currentNode);
            // Update the key value in the priority queue.
            (*handle).first = currentNode->getPathDensity();
            // "Reorder" the elements in the priority queue to reflect this change. 
            node_priority_queue.update(handle);
        }

        // Enqueue all children of the current node (lock weak_ptr to shared_ptr)
        for (const auto& weak_child : currentNode->children_) {
            if (auto child = weak_child.lock()) {
                queue.push(child);
            }
        }
    }

    return true;
}
