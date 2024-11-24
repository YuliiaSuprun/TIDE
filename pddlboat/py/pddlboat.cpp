#include <pybind11/pybind11.h>
#include <pybind11/operators.h>
#include <pybind11/stl.h>
#include <pybind11/eigen.h>
#include <pybind11/stl_bind.h>
#include <pybind11/cast.h>
#include <pybind11/functional.h>

template <typename ElemT, typename ResultT=ElemT>
std::vector<ResultT> convertVec(const std::vector<ElemT>& vec) {
  return vec;
}

template<>
std::vector<const char*> convertVec(const std::vector<std::string>& vec) {
  std::vector<const char*> result;
  result.reserve(vec.size());
  for(const auto& str: vec) {
    result.push_back(str.c_str());
  }

  return result;
}
#include <pddlboat/parser/ast.hpp>
#include <pddlboat/parser/parser.hpp>
#include <pddlboat/parser/translator.hpp>
#include <pddlboat/solver/astarplanner.hpp>
#include <pddlboat/solver/dependency.hpp>
#include <pddlboat/solver/domain.hpp>
#include <pddlboat/solver/expression.hpp>
#include <pddlboat/solver/expressions.hpp>
#include <pddlboat/solver/fdplanner.hpp>
#include <pddlboat/solver/ffplanner.hpp>
#include <pddlboat/solver/planner.hpp>
#include <pddlboat/solver/symkplanner.hpp>
#include <pddlboat/solver/variables.hpp>
#include <pddlboat/solver/z3planner.hpp>
namespace py = pybind11;
PYBIND11_MODULE(pddlboat, m) {
py::module_ ast_m = m.def_submodule("ast");
// Bindings for class pddlboat::VariableSet
py::class_<pddlboat::VariableSet, std::shared_ptr<pddlboat::VariableSet>>(m, "VariableSet")
.def(py::init())
.def(py::init<const std::vector<pddlboat::Variable> &>())
.def("merge", &pddlboat::VariableSet::merge)
.def("remove", static_cast<void (pddlboat::VariableSet::*)(const pddlboat::VariableSet &)>(&pddlboat::VariableSet::remove))
.def("remove", static_cast<void (pddlboat::VariableSet::*)(const std::vector<pddlboat::Variable> &)>(&pddlboat::VariableSet::remove))
.def("add_variable", &pddlboat::VariableSet::addVariable)
.def("remove_variable", &pddlboat::VariableSet::removeVariable)
.def("get_names", &pddlboat::VariableSet::getNames)
.def("get_variable", &pddlboat::VariableSet::getVariable)
.def("__repr__", [](const pddlboat::VariableSet &o){std::stringstream ss; o.toPDDL(ss); return ss.str();})
.def(py::self == py::self)
.def(py::self != py::self)
.def("contains", &pddlboat::VariableSet::contains)
.def_readwrite("variables", &pddlboat::VariableSet::variables)
;
// Bindings for class pddlboat::Variable
py::class_<pddlboat::Variable, std::shared_ptr<pddlboat::Variable>>(m, "Variable")
.def(py::init<const std::pair<std::basic_string<char>, std::basic_string<char>> &>())
.def(py::init<const std::basic_string<char> &, const std::basic_string<char> &>())
.def(py::self < py::self)
.def(py::self == py::self)
.def(py::self != py::self)
.def_readwrite("name", &pddlboat::Variable::name)
.def_readwrite("type", &pddlboat::Variable::type)
;
// Bindings for class pddlboat::Object
py::class_<pddlboat::Object, std::shared_ptr<pddlboat::Object>>(m, "Object")
.def(py::init<const std::basic_string<char> &, const std::basic_string<char> &>())
.def_readwrite("name", &pddlboat::Object::name)
.def_readwrite("type", &pddlboat::Object::type)
;
// Bindings for class pddlboat::Planner
py::class_<pddlboat::Planner, std::shared_ptr<pddlboat::Planner>> py_pddlboat_Planner(m, "Planner");
py_pddlboat_Planner.def("solve", static_cast<bool (pddlboat::Planner::*)(pddlboat::Plan &)>(&pddlboat::Planner::solve))
.def("solve", static_cast<bool (pddlboat::Planner::*)(pddlboat::Plan &, unsigned int)>(&pddlboat::Planner::solve))
.def("reset", &pddlboat::Planner::reset)
.def("block_plan_step", &pddlboat::Planner::blockPlanStep)
.def("block_state_action", &pddlboat::Planner::blockStateAction)
.def("block_state_actions", &pddlboat::Planner::blockStateActions)
.def("block_expression_action", &pddlboat::Planner::blockExpressionAction)
.def("block_expression_actions", &pddlboat::Planner::blockExpressionActions)
.def("add_constraint", &pddlboat::Planner::addConstraint)
.def("block_state_actions_simultaneous", &pddlboat::Planner::blockStateActionsSimultaneous)
.def("get_supported_requirements", &pddlboat::Planner::getSupportedRequirements)
.def("check_requirements", &pddlboat::Planner::checkRequirements)
.def("get_problem", &pddlboat::Planner::getProblem)
;
// Bindings for class pddlboat::Z3Planner
py::class_<pddlboat::Z3Planner, pddlboat::Planner, std::shared_ptr<pddlboat::Z3Planner>> py_pddlboat_Z3Planner(m, "Z3Planner");
py_pddlboat_Z3Planner.def(py::init<const std::shared_ptr<pddlboat::Problem> &, const pddlboat::Z3Planner::Options &>())
.def("reset", &pddlboat::Z3Planner::reset)
.def("get_supported_requirements", &pddlboat::Z3Planner::getSupportedRequirements)
.def("solve", static_cast<bool (pddlboat::Z3Planner::*)(pddlboat::Plan &)>(&pddlboat::Z3Planner::solve))
.def("solve", static_cast<bool (pddlboat::Z3Planner::*)(pddlboat::Plan &, unsigned int)>(&pddlboat::Z3Planner::solve))
.def("block_state_actions", &pddlboat::Z3Planner::blockStateActions)
.def("block_state_actions_simultaneous", &pddlboat::Z3Planner::blockStateActionsSimultaneous)
.def("block_expression_actions", &pddlboat::Z3Planner::blockExpressionActions)
.def("add_constraint", &pddlboat::Z3Planner::addConstraint)
.def("print_model", &pddlboat::Z3Planner::printModel)
.def("print_smt2", &pddlboat::Z3Planner::printSMT2)
;
// Bindings for class pddlboat::Z3Planner::Options
py::class_<pddlboat::Z3Planner::Options, std::shared_ptr<pddlboat::Z3Planner::Options>>(py_pddlboat_Z3Planner, "Options")
.def(py::init())
.def_readwrite("horizon_max", &pddlboat::Z3Planner::Options::horizon_max)
.def_readwrite("horizon_min", &pddlboat::Z3Planner::Options::horizon_min)
.def_readwrite("parallel", &pddlboat::Z3Planner::Options::parallel)
.def_readwrite("diagnostics", &pddlboat::Z3Planner::Options::diagnostics)
.def_readwrite("dump_clauses", &pddlboat::Z3Planner::Options::dump_clauses)
.def_readwrite("incremental", &pddlboat::Z3Planner::Options::incremental)
.def_readwrite("simultaneous", &pddlboat::Z3Planner::Options::simultaneous)
.def_readwrite("optimize", &pddlboat::Z3Planner::Options::optimize)
;
// Bindings for enum pddlboat::Planner::ConstraintTime
py::enum_<pddlboat::Planner::ConstraintTime>(py_pddlboat_Planner, "ConstraintTime")
.value("AT_END", pddlboat::Planner::ConstraintTime::AT_END)
.value("OVER_ALL", pddlboat::Planner::ConstraintTime::OVER_ALL)
.export_values()
;
// Bindings for class pddlboat::FastForwardPlanner
py::class_<pddlboat::FastForwardPlanner, pddlboat::Planner, std::shared_ptr<pddlboat::FastForwardPlanner>> py_pddlboat_FastForwardPlanner(m, "FastForwardPlanner");
py_pddlboat_FastForwardPlanner.def(py::init<const std::shared_ptr<pddlboat::Problem> &, const pddlboat::FastForwardPlanner::Options &>())
.def("get_supported_requirements", &pddlboat::FastForwardPlanner::getSupportedRequirements)
.def("update", &pddlboat::FastForwardPlanner::update)
.def("solve", static_cast<bool (pddlboat::FastForwardPlanner::*)(pddlboat::Plan &)>(&pddlboat::FastForwardPlanner::solve))
.def("solve", static_cast<bool (pddlboat::FastForwardPlanner::*)(pddlboat::Plan &, unsigned int)>(&pddlboat::FastForwardPlanner::solve))
;
// Bindings for class pddlboat::FastForwardPlanner::Options
py::class_<pddlboat::FastForwardPlanner::Options, std::shared_ptr<pddlboat::FastForwardPlanner::Options>>(py_pddlboat_FastForwardPlanner, "Options")
.def(py::init())
;
// Bindings for class pddlboat::FastDownwardPlanner
py::class_<pddlboat::FastDownwardPlanner, pddlboat::Planner, std::shared_ptr<pddlboat::FastDownwardPlanner>> py_pddlboat_FastDownwardPlanner(m, "FastDownwardPlanner");
py_pddlboat_FastDownwardPlanner.def(py::init<const std::shared_ptr<pddlboat::Problem> &, const pddlboat::FastDownwardPlanner::Options &>())
.def("get_supported_requirements", &pddlboat::FastDownwardPlanner::getSupportedRequirements)
.def("update", &pddlboat::FastDownwardPlanner::update)
.def("solve", static_cast<bool (pddlboat::FastDownwardPlanner::*)(pddlboat::Plan &)>(&pddlboat::FastDownwardPlanner::solve))
.def("solve", static_cast<bool (pddlboat::FastDownwardPlanner::*)(pddlboat::Plan &, unsigned int)>(&pddlboat::FastDownwardPlanner::solve))
;
// Bindings for class pddlboat::SymKPlanner
py::class_<pddlboat::SymKPlanner, pddlboat::FastDownwardPlanner, std::shared_ptr<pddlboat::SymKPlanner>> py_pddlboat_SymKPlanner(m, "SymKPlanner");
py_pddlboat_SymKPlanner.def(py::init<const std::shared_ptr<pddlboat::Problem> &, pddlboat::SymKPlanner::SolutionSelector, unsigned int, float, bool>())
.def("get_supported_requirements", &pddlboat::SymKPlanner::getSupportedRequirements)
.def("multi_solve", &pddlboat::SymKPlanner::multiSolve)
.def("anytime_solve", &pddlboat::SymKPlanner::anytimeSolve)
;
// Bindings for enum pddlboat::SymKPlanner::SolutionSelector
py::enum_<pddlboat::SymKPlanner::SolutionSelector>(py_pddlboat_SymKPlanner, "SolutionSelector")
.value("TOPK", pddlboat::SymKPlanner::SolutionSelector::TOPK)
.value("TOPQ", pddlboat::SymKPlanner::SolutionSelector::TOPQ)
.export_values()
;
// Bindings for class pddlboat::FastDownwardPlanner::Options
py::class_<pddlboat::FastDownwardPlanner::Options, std::shared_ptr<pddlboat::FastDownwardPlanner::Options>>(py_pddlboat_FastDownwardPlanner, "Options")
.def(py::init())
.def_readwrite("search", &pddlboat::FastDownwardPlanner::Options::search)
.def_readwrite("no_simplify_sas", &pddlboat::FastDownwardPlanner::Options::no_simplify_sas)
;
// Bindings for enum pddlboat::FastDownwardPlanner::Search
py::enum_<pddlboat::FastDownwardPlanner::Search>(py_pddlboat_FastDownwardPlanner, "Search")
.value("ASTAR", pddlboat::FastDownwardPlanner::Search::ASTAR)
.value("LAZYGREEDY", pddlboat::FastDownwardPlanner::Search::LAZYGREEDY)
.value("FDAT", pddlboat::FastDownwardPlanner::Search::FDAT)
.value("LAMA", pddlboat::FastDownwardPlanner::Search::LAMA)
.value("LAMA_FIRST", pddlboat::FastDownwardPlanner::Search::LAMA_FIRST)
.export_values()
;
// Bindings for class pddlboat::AStarPlanner
py::class_<pddlboat::AStarPlanner, pddlboat::Planner, std::shared_ptr<pddlboat::AStarPlanner>> py_pddlboat_AStarPlanner(m, "AStarPlanner");
py_pddlboat_AStarPlanner.def(py::init<const std::shared_ptr<pddlboat::Problem> &, const pddlboat::AStarPlanner::Options &>())
.def("get_start_neighbors", &pddlboat::AStarPlanner::getStartNeighbors)
.def("random_walk", &pddlboat::AStarPlanner::randomWalk)
.def("initialize", &pddlboat::AStarPlanner::initialize)
.def("solve", static_cast<bool (pddlboat::AStarPlanner::*)(pddlboat::Plan &)>(&pddlboat::AStarPlanner::solve))
.def("solve", static_cast<bool (pddlboat::AStarPlanner::*)(pddlboat::Plan &, unsigned int)>(&pddlboat::AStarPlanner::solve))
.def("block_state_actions", &pddlboat::AStarPlanner::blockStateActions)
.def("generate_graph_ml", &pddlboat::AStarPlanner::generateGraphML)
.def("get_supported_requirements", &pddlboat::AStarPlanner::getSupportedRequirements)
.def_readwrite("options", &pddlboat::AStarPlanner::options)
.def_readonly_static("default_transition_distance", &pddlboat::AStarPlanner::DEFAULT_TRANSITION_DISTANCE)
.def_readonly_static("total_cost_transition_distance", &pddlboat::AStarPlanner::TOTAL_COST_TRANSITION_DISTANCE)
.def_readonly_static("null_heuristic", &pddlboat::AStarPlanner::NULL_HEURISTIC)
;
// Bindings for class pddlboat::AStarPlanner::Options
py::class_<pddlboat::AStarPlanner::Options, std::shared_ptr<pddlboat::AStarPlanner::Options>>(py_pddlboat_AStarPlanner, "Options")
.def(py::init())
.def_readwrite("verbose", &pddlboat::AStarPlanner::Options::verbose)
.def_readwrite("transition_distance", &pddlboat::AStarPlanner::Options::transition_distance)
.def_readwrite("heuristic", &pddlboat::AStarPlanner::Options::heuristic)
;
// Bindings for class pddlboat::PlanWatcher
py::class_<pddlboat::PlanWatcher, std::shared_ptr<pddlboat::PlanWatcher>>(m, "PlanWatcher")
.def(py::init<const std::filesystem::path &, const std::basic_string<char> &, const std::shared_ptr<pddlboat::Problem> &, const std::basic_string<char> &, bool, unsigned int, unsigned int>())
.def("start", &pddlboat::PlanWatcher::start)
.def("stop", &pddlboat::PlanWatcher::stop)
.def("get_next_plan_idx", &pddlboat::PlanWatcher::getNextPlanIdx)
.def("planner_running", &pddlboat::PlanWatcher::plannerRunning)
.def("get_plan_idx", &pddlboat::PlanWatcher::getPlanIdx)
.def("get_plans", &pddlboat::PlanWatcher::getPlans)
;
// Bindings for class pddlboat::PlanSet
py::class_<pddlboat::PlanSet, std::shared_ptr<pddlboat::PlanSet>>(m, "PlanSet")
.def(py::init<const std::shared_ptr<pddlboat::Problem> &>())
.def(py::init<const pddlboat::PlanSet &>())
.def("add_plan", &pddlboat::PlanSet::addPlan)
.def("new_plan", &pddlboat::PlanSet::newPlan)
.def("clear", &pddlboat::PlanSet::clear)
.def("get_plan", &pddlboat::PlanSet::getPlan)
.def("__getitem__", [](pddlboat::PlanSet &s, unsigned long i) { return s[i]; })
.def("get_plan_const", &pddlboat::PlanSet::getPlanConst)
.def("begin", &pddlboat::PlanSet::begin)
.def("end", &pddlboat::PlanSet::end)
.def("cbegin", &pddlboat::PlanSet::cbegin)
.def("cend", &pddlboat::PlanSet::cend)
.def("count", &pddlboat::PlanSet::count)
.def("get_problem", &pddlboat::PlanSet::getProblem)
;
// Bindings for class pddlboat::Plan
py::class_<pddlboat::Plan, std::shared_ptr<pddlboat::Plan>> py_pddlboat_Plan(m, "Plan");
py_pddlboat_Plan.def(py::init<const std::shared_ptr<pddlboat::Problem> &>())
.def(py::init<const pddlboat::Plan &>())
.def("add_step", &pddlboat::Plan::addStep)
.def("insert_step", &pddlboat::Plan::insertStep)
.def("add_step_action", &pddlboat::Plan::addStepAction)
.def("insert_step_action", &pddlboat::Plan::insertStepAction)
.def("get_step", &pddlboat::Plan::getStep)
.def("get_step_const", &pddlboat::Plan::getStepConst)
.def("get_steps", &pddlboat::Plan::getSteps)
.def("get_makespan", &pddlboat::Plan::getMakespan)
.def("get_steps_at_makespan", &pddlboat::Plan::getStepsAtMakespan)
.def("get_makespan_steps", &pddlboat::Plan::getMakespanSteps)
.def("get_num_steps", &pddlboat::Plan::getNumSteps)
.def("get_step_states", &pddlboat::Plan::getStepStates)
.def("validate", &pddlboat::Plan::validate)
.def("__repr__", [](const pddlboat::Plan &o){std::stringstream ss; o.toString(ss); return ss.str();})
.def("get_problem", &pddlboat::Plan::getProblem)
.def("get_time_taken", &pddlboat::Plan::getTimeTaken)
.def("set_time_taken", &pddlboat::Plan::setTimeTaken)
;
// Bindings for class pddlboat::Plan::Step
py::class_<pddlboat::Plan::Step, std::shared_ptr<pddlboat::Plan::Step>>(py_pddlboat_Plan, "Step")
.def(py::init<const std::shared_ptr<pddlboat::Action> &, const pddlboat::Assignment &>())
.def("__repr__", [](const pddlboat::Plan::Step &o){std::stringstream ss; o.toString(ss); return ss.str();})
.def_readwrite("action", &pddlboat::Plan::Step::action)
.def_readwrite("assignment", &pddlboat::Plan::Step::assignment)
.def_readwrite("prior", &pddlboat::Plan::Step::prior)
.def_readwrite("state", &pddlboat::Plan::Step::state)
;
// Bindings for class pddlboat::Value
py::class_<pddlboat::Value, std::shared_ptr<pddlboat::Value>>(m, "Value")
.def(py::init<bool, const std::basic_string<char> &, const std::basic_string<char> &>())
.def(py::init<const std::shared_ptr<pddlboat::ObjectFunction> &>())
.def("get_object", &pddlboat::Value::getObject)
.def("get_variables", &pddlboat::Value::getVariables)
.def("contains_variable", &pddlboat::Value::containsVariable)
.def("rename_variable", &pddlboat::Value::renameVariable)
.def("get_used_functions", &pddlboat::Value::getUsedFunctions)
.def("__repr__", [](const pddlboat::Value &o){std::stringstream ss; o.toPDDL(ss); return ss.str();})
.def("__repr__", [](const pddlboat::Value &o){std::stringstream ss; o.toString(ss); return ss.str();})
.def_readwrite("is_var", &pddlboat::Value::isVar)
.def_readwrite("name", &pddlboat::Value::name)
.def_readwrite("type", &pddlboat::Value::type)
.def_readwrite("function", &pddlboat::Value::function)
;
// Bindings for class pddlboat::Expression
py::class_<pddlboat::Expression, std::shared_ptr<pddlboat::Expression>> py_pddlboat_Expression(m, "Expression");
py_pddlboat_Expression.def("evaluate", &pddlboat::Expression::evaluate)
.def("assign", &pddlboat::Expression::assign)
.def("type", &pddlboat::Expression::type)
.def("get_types", &pddlboat::Expression::getTypes)
.def("get_variables", &pddlboat::Expression::getVariables)
.def("get_used_predicates", &pddlboat::Expression::getUsedPredicates)
.def("get_assigned_predicates", &pddlboat::Expression::getAssignedPredicates)
.def("get_effects", &pddlboat::Expression::getEffects)
.def("contains_variable", &pddlboat::Expression::containsVariable)
.def("contains_predicate", &pddlboat::Expression::containsPredicate)
.def("rename_variable", &pddlboat::Expression::renameVariable)
.def("__repr__", [](const pddlboat::Expression &o){std::stringstream ss; o.toPDDL(ss); return ss.str();})
;
// Bindings for class pddlboat::AssignNumber
py::class_<pddlboat::AssignNumber, pddlboat::Expression, std::shared_ptr<pddlboat::AssignNumber>>(m, "AssignNumber")
.def(py::init<const std::shared_ptr<pddlboat::NumericFunction> &, const std::shared_ptr<pddlboat::NumericExpression> &>())
.def(py::init<const std::shared_ptr<pddlboat::NumericFunction> &, double>())
.def("get_lhs_value", &pddlboat::AssignNumber::getLHSValue)
.def("get_rhs_value", &pddlboat::AssignNumber::getRHSValue)
.def("get_lhs", &pddlboat::AssignNumber::getLHS)
.def("get_rhs", &pddlboat::AssignNumber::getRHS)
.def("assign", &pddlboat::AssignNumber::assign)
.def("type", &pddlboat::AssignNumber::type)
.def("get_variables", &pddlboat::AssignNumber::getVariables)
.def("get_used_predicates", &pddlboat::AssignNumber::getUsedPredicates)
.def("get_assigned_predicates", &pddlboat::AssignNumber::getAssignedPredicates)
.def("contains_variable", &pddlboat::AssignNumber::containsVariable)
.def("rename_variable", &pddlboat::AssignNumber::renameVariable)
.def("__repr__", [](const pddlboat::AssignNumber &o){std::stringstream ss; o.toPDDL(ss); return ss.str();})
;
// Bindings for class pddlboat::Decrease
py::class_<pddlboat::Decrease, pddlboat::AssignNumber, std::shared_ptr<pddlboat::Decrease>>(m, "Decrease")
.def(py::init<const std::shared_ptr<pddlboat::NumericFunction> &, const std::shared_ptr<pddlboat::NumericExpression> &>())
.def(py::init<const std::shared_ptr<pddlboat::NumericFunction> &, double>())
.def("type", &pddlboat::Decrease::type)
.def("get_rhs_value", &pddlboat::Decrease::getRHSValue)
;
// Bindings for class pddlboat::Increase
py::class_<pddlboat::Increase, pddlboat::AssignNumber, std::shared_ptr<pddlboat::Increase>>(m, "Increase")
.def(py::init<const std::shared_ptr<pddlboat::NumericFunction> &, const std::shared_ptr<pddlboat::NumericExpression> &>())
.def(py::init<const std::shared_ptr<pddlboat::NumericFunction> &, double>())
.def("type", &pddlboat::Increase::type)
.def("get_rhs_value", &pddlboat::Increase::getRHSValue)
;
// Bindings for class pddlboat::ScaleDown
py::class_<pddlboat::ScaleDown, pddlboat::AssignNumber, std::shared_ptr<pddlboat::ScaleDown>>(m, "ScaleDown")
.def(py::init<const std::shared_ptr<pddlboat::NumericFunction> &, const std::shared_ptr<pddlboat::NumericExpression> &>())
.def(py::init<const std::shared_ptr<pddlboat::NumericFunction> &, double>())
.def("type", &pddlboat::ScaleDown::type)
.def("get_rhs_value", &pddlboat::ScaleDown::getRHSValue)
;
// Bindings for class pddlboat::ScaleUp
py::class_<pddlboat::ScaleUp, pddlboat::AssignNumber, std::shared_ptr<pddlboat::ScaleUp>>(m, "ScaleUp")
.def(py::init<const std::shared_ptr<pddlboat::NumericFunction> &, const std::shared_ptr<pddlboat::NumericExpression> &>())
.def(py::init<const std::shared_ptr<pddlboat::NumericFunction> &, double>())
.def("type", &pddlboat::ScaleUp::type)
.def("get_rhs_value", &pddlboat::ScaleUp::getRHSValue)
;
// Bindings for class pddlboat::AssignObject
py::class_<pddlboat::AssignObject, pddlboat::Expression, std::shared_ptr<pddlboat::AssignObject>>(m, "AssignObject")
.def(py::init<const std::shared_ptr<pddlboat::ObjectFunction> &, const pddlboat::Value &>())
.def("assign", &pddlboat::AssignObject::assign)
.def("type", &pddlboat::AssignObject::type)
.def("get_variables", &pddlboat::AssignObject::getVariables)
.def("get_used_predicates", &pddlboat::AssignObject::getUsedPredicates)
.def("get_assigned_predicates", &pddlboat::AssignObject::getAssignedPredicates)
.def("contains_variable", &pddlboat::AssignObject::containsVariable)
.def("rename_variable", &pddlboat::AssignObject::renameVariable)
.def("__repr__", [](const pddlboat::AssignObject &o){std::stringstream ss; o.toPDDL(ss); return ss.str();})
;
// Bindings for class pddlboat::Equals
py::class_<pddlboat::Equals, pddlboat::Expression, std::shared_ptr<pddlboat::Equals>>(m, "Equals")
.def(py::init<const pddlboat::Value &, const pddlboat::Value &>())
.def("get_terms", &pddlboat::Equals::getTerms)
.def("assign", &pddlboat::Equals::assign)
.def("evaluate", &pddlboat::Equals::evaluate)
.def("type", &pddlboat::Equals::type)
.def("get_types", &pddlboat::Equals::getTypes)
.def("get_used_predicates", &pddlboat::Equals::getUsedPredicates)
.def("get_assigned_predicates", &pddlboat::Equals::getAssignedPredicates)
.def("get_effects", &pddlboat::Equals::getEffects)
.def("get_variables", &pddlboat::Equals::getVariables)
.def("contains_variable", &pddlboat::Equals::containsVariable)
.def("contains_predicate", &pddlboat::Equals::containsPredicate)
.def("rename_variable", &pddlboat::Equals::renameVariable)
.def("__repr__", [](const pddlboat::Equals &o){std::stringstream ss; o.toPDDL(ss); return ss.str();})
;
// Bindings for class pddlboat::QuantifierExpression
py::class_<pddlboat::QuantifierExpression, pddlboat::Expression, std::shared_ptr<pddlboat::QuantifierExpression>>(m, "QuantifierExpression")
.def("get_domain", &pddlboat::QuantifierExpression::getDomain)
.def("get_formula", &pddlboat::QuantifierExpression::getFormula)
.def("type", &pddlboat::QuantifierExpression::type)
.def("get_types", &pddlboat::QuantifierExpression::getTypes)
.def("get_used_predicates", &pddlboat::QuantifierExpression::getUsedPredicates)
.def("get_variables", &pddlboat::QuantifierExpression::getVariables)
.def("contains_variable", &pddlboat::QuantifierExpression::containsVariable)
.def("contains_predicate", &pddlboat::QuantifierExpression::containsPredicate)
.def("rename_variable", &pddlboat::QuantifierExpression::renameVariable)
;
// Bindings for class pddlboat::Forall
py::class_<pddlboat::Forall, pddlboat::QuantifierExpression, std::shared_ptr<pddlboat::Forall>>(m, "Forall")
.def(py::init<const pddlboat::VariableSet &, const std::shared_ptr<pddlboat::Expression> &>())
.def("evaluate", &pddlboat::Forall::evaluate)
.def("assign", &pddlboat::Forall::assign)
.def("get_assigned_predicates", &pddlboat::Forall::getAssignedPredicates)
.def("get_effects", &pddlboat::Forall::getEffects)
.def("type", &pddlboat::Forall::type)
.def("__repr__", [](const pddlboat::Forall &o){std::stringstream ss; o.toPDDL(ss); return ss.str();})
;
// Bindings for class pddlboat::Exists
py::class_<pddlboat::Exists, pddlboat::QuantifierExpression, std::shared_ptr<pddlboat::Exists>>(m, "Exists")
.def(py::init<const pddlboat::VariableSet &, const std::shared_ptr<pddlboat::Expression> &>())
.def("evaluate", &pddlboat::Exists::evaluate)
.def("type", &pddlboat::Exists::type)
.def("__repr__", [](const pddlboat::Exists &o){std::stringstream ss; o.toPDDL(ss); return ss.str();})
;
// Bindings for class pddlboat::When
py::class_<pddlboat::When, pddlboat::Expression, std::shared_ptr<pddlboat::When>>(m, "When")
.def(py::init<const std::shared_ptr<pddlboat::Expression> &, const std::shared_ptr<pddlboat::Expression> &>())
.def("get_left", &pddlboat::When::getLeft)
.def("get_right", &pddlboat::When::getRight)
.def("evaluate", &pddlboat::When::evaluate)
.def("assign", &pddlboat::When::assign)
.def("type", &pddlboat::When::type)
.def("get_types", &pddlboat::When::getTypes)
.def("get_variables", &pddlboat::When::getVariables)
.def("get_used_predicates", &pddlboat::When::getUsedPredicates)
.def("get_assigned_predicates", &pddlboat::When::getAssignedPredicates)
.def("get_effects", &pddlboat::When::getEffects)
.def("contains_variable", &pddlboat::When::containsVariable)
.def("contains_predicate", &pddlboat::When::containsPredicate)
.def("rename_variable", &pddlboat::When::renameVariable)
.def("__repr__", [](const pddlboat::When &o){std::stringstream ss; o.toPDDL(ss); return ss.str();})
;
// Bindings for class pddlboat::Imply
py::class_<pddlboat::Imply, pddlboat::Expression, std::shared_ptr<pddlboat::Imply>>(m, "Imply")
.def(py::init<const std::shared_ptr<pddlboat::Expression> &, const std::shared_ptr<pddlboat::Expression> &>())
.def("get_left", &pddlboat::Imply::getLeft)
.def("get_right", &pddlboat::Imply::getRight)
.def("evaluate", &pddlboat::Imply::evaluate)
.def("type", &pddlboat::Imply::type)
.def("get_types", &pddlboat::Imply::getTypes)
.def("get_used_predicates", &pddlboat::Imply::getUsedPredicates)
.def("get_variables", &pddlboat::Imply::getVariables)
.def("contains_variable", &pddlboat::Imply::containsVariable)
.def("contains_predicate", &pddlboat::Imply::containsPredicate)
.def("rename_variable", &pddlboat::Imply::renameVariable)
.def("__repr__", [](const pddlboat::Imply &o){std::stringstream ss; o.toPDDL(ss); return ss.str();})
;
// Bindings for class pddlboat::Not
py::class_<pddlboat::Not, pddlboat::Expression, std::shared_ptr<pddlboat::Not>>(m, "Not")
.def(py::init<const std::shared_ptr<pddlboat::Expression> &>())
.def("get_term", &pddlboat::Not::getTerm)
.def("evaluate", &pddlboat::Not::evaluate)
.def("assign", &pddlboat::Not::assign)
.def("type", &pddlboat::Not::type)
.def("get_types", &pddlboat::Not::getTypes)
.def("get_variables", &pddlboat::Not::getVariables)
.def("get_used_predicates", &pddlboat::Not::getUsedPredicates)
.def("get_assigned_predicates", &pddlboat::Not::getAssignedPredicates)
.def("get_effects", &pddlboat::Not::getEffects)
.def("contains_variable", &pddlboat::Not::containsVariable)
.def("contains_predicate", &pddlboat::Not::containsPredicate)
.def("rename_variable", &pddlboat::Not::renameVariable)
.def("__repr__", [](const pddlboat::Not &o){std::stringstream ss; o.toPDDL(ss); return ss.str();})
;
// Bindings for class pddlboat::VariadicExpression
py::class_<pddlboat::VariadicExpression, pddlboat::Expression, std::shared_ptr<pddlboat::VariadicExpression>>(m, "VariadicExpression")
.def("add_term", &pddlboat::VariadicExpression::addTerm)
.def("get_terms", &pddlboat::VariadicExpression::getTerms)
.def("type", &pddlboat::VariadicExpression::type)
.def("get_types", &pddlboat::VariadicExpression::getTypes)
.def("get_variables", &pddlboat::VariadicExpression::getVariables)
.def("get_used_predicates", &pddlboat::VariadicExpression::getUsedPredicates)
.def("get_assigned_predicates", &pddlboat::VariadicExpression::getAssignedPredicates)
.def("get_effects", &pddlboat::VariadicExpression::getEffects)
.def("contains_variable", &pddlboat::VariadicExpression::containsVariable)
.def("contains_predicate", &pddlboat::VariadicExpression::containsPredicate)
.def("rename_variable", &pddlboat::VariadicExpression::renameVariable)
;
// Bindings for class pddlboat::Or
py::class_<pddlboat::Or, pddlboat::VariadicExpression, std::shared_ptr<pddlboat::Or>>(m, "Or")
.def(py::init<const std::vector<std::shared_ptr<pddlboat::Expression>> &>())
.def("evaluate", &pddlboat::Or::evaluate)
.def("type", &pddlboat::Or::type)
.def("__repr__", [](const pddlboat::Or &o){std::stringstream ss; o.toPDDL(ss); return ss.str();})
;
// Bindings for class pddlboat::And
py::class_<pddlboat::And, pddlboat::VariadicExpression, std::shared_ptr<pddlboat::And>>(m, "And")
.def(py::init<const std::vector<std::shared_ptr<pddlboat::Expression>> &>())
.def("evaluate", &pddlboat::And::evaluate)
.def("assign", &pddlboat::And::assign)
.def("type", &pddlboat::And::type)
.def("__repr__", [](const pddlboat::And &o){std::stringstream ss; o.toPDDL(ss); return ss.str();})
;
// Bindings for class pddlboat::NumericExpression
py::class_<pddlboat::NumericExpression, pddlboat::Expression, std::shared_ptr<pddlboat::NumericExpression>>(m, "NumericExpression")
.def("get_value", &pddlboat::NumericExpression::getValue)
;
// Bindings for class pddlboat::BinaryExpression
py::class_<pddlboat::BinaryExpression, pddlboat::NumericExpression, std::shared_ptr<pddlboat::BinaryExpression>>(m, "BinaryExpression")
.def(py::init<const std::shared_ptr<pddlboat::NumericExpression> &, const std::shared_ptr<pddlboat::NumericExpression> &>())
.def("get_lhs", &pddlboat::BinaryExpression::getLHS)
.def("get_rhs", &pddlboat::BinaryExpression::getRHS)
.def("get_types", &pddlboat::BinaryExpression::getTypes)
.def("get_variables", &pddlboat::BinaryExpression::getVariables)
.def("get_used_predicates", &pddlboat::BinaryExpression::getUsedPredicates)
.def("contains_variable", &pddlboat::BinaryExpression::containsVariable)
.def("contains_predicate", &pddlboat::BinaryExpression::containsPredicate)
.def("rename_variable", &pddlboat::BinaryExpression::renameVariable)
.def("__repr__", [](const pddlboat::BinaryExpression &o){std::stringstream ss; o.toPDDL(ss); return ss.str();})
;
// Bindings for class pddlboat::Plus
py::class_<pddlboat::Plus, pddlboat::BinaryExpression, std::shared_ptr<pddlboat::Plus>>(m, "Plus")
.def(py::init<const std::shared_ptr<pddlboat::NumericExpression> &, const std::shared_ptr<pddlboat::NumericExpression> &>())
.def("type", &pddlboat::Plus::type)
.def("get_value", &pddlboat::Plus::getValue)
;
// Bindings for class pddlboat::Multiply
py::class_<pddlboat::Multiply, pddlboat::BinaryExpression, std::shared_ptr<pddlboat::Multiply>>(m, "Multiply")
.def(py::init<const std::shared_ptr<pddlboat::NumericExpression> &, const std::shared_ptr<pddlboat::NumericExpression> &>())
.def("type", &pddlboat::Multiply::type)
.def("get_value", &pddlboat::Multiply::getValue)
;
// Bindings for class pddlboat::Divide
py::class_<pddlboat::Divide, pddlboat::BinaryExpression, std::shared_ptr<pddlboat::Divide>>(m, "Divide")
.def(py::init<const std::shared_ptr<pddlboat::NumericExpression> &, const std::shared_ptr<pddlboat::NumericExpression> &>())
.def("type", &pddlboat::Divide::type)
.def("get_value", &pddlboat::Divide::getValue)
;
// Bindings for class pddlboat::Minus
py::class_<pddlboat::Minus, pddlboat::BinaryExpression, std::shared_ptr<pddlboat::Minus>>(m, "Minus")
.def(py::init<const std::shared_ptr<pddlboat::NumericExpression> &, const std::shared_ptr<pddlboat::NumericExpression> &>())
.def("type", &pddlboat::Minus::type)
.def("get_value", &pddlboat::Minus::getValue)
;
// Bindings for class pddlboat::LessOrEqual
py::class_<pddlboat::LessOrEqual, pddlboat::BinaryExpression, std::shared_ptr<pddlboat::LessOrEqual>>(m, "LessOrEqual")
.def(py::init<const std::shared_ptr<pddlboat::NumericExpression> &, const std::shared_ptr<pddlboat::NumericExpression> &>())
.def("type", &pddlboat::LessOrEqual::type)
.def("evaluate", &pddlboat::LessOrEqual::evaluate)
;
// Bindings for class pddlboat::GreaterOrEqual
py::class_<pddlboat::GreaterOrEqual, pddlboat::BinaryExpression, std::shared_ptr<pddlboat::GreaterOrEqual>>(m, "GreaterOrEqual")
.def(py::init<const std::shared_ptr<pddlboat::NumericExpression> &, const std::shared_ptr<pddlboat::NumericExpression> &>())
.def("type", &pddlboat::GreaterOrEqual::type)
.def("evaluate", &pddlboat::GreaterOrEqual::evaluate)
;
// Bindings for class pddlboat::LessThan
py::class_<pddlboat::LessThan, pddlboat::BinaryExpression, std::shared_ptr<pddlboat::LessThan>>(m, "LessThan")
.def(py::init<const std::shared_ptr<pddlboat::NumericExpression> &, const std::shared_ptr<pddlboat::NumericExpression> &>())
.def("type", &pddlboat::LessThan::type)
.def("evaluate", &pddlboat::LessThan::evaluate)
;
// Bindings for class pddlboat::GreaterThan
py::class_<pddlboat::GreaterThan, pddlboat::BinaryExpression, std::shared_ptr<pddlboat::GreaterThan>>(m, "GreaterThan")
.def(py::init<const std::shared_ptr<pddlboat::NumericExpression> &, const std::shared_ptr<pddlboat::NumericExpression> &>())
.def("type", &pddlboat::GreaterThan::type)
.def("evaluate", &pddlboat::GreaterThan::evaluate)
;
// Bindings for class pddlboat::NumericFunction
py::class_<pddlboat::NumericFunction, pddlboat::NumericExpression, std::shared_ptr<pddlboat::NumericFunction>>(m, "NumericFunction")
.def(py::init<const pddlboat::NumericFunctionDefinition *, const std::vector<pddlboat::Value> &>())
.def("get_name", &pddlboat::NumericFunction::getName)
.def("get_value", &pddlboat::NumericFunction::getValue)
.def("type", &pddlboat::NumericFunction::type)
.def("get_variables", &pddlboat::NumericFunction::getVariables)
.def("contains_variable", &pddlboat::NumericFunction::containsVariable)
.def("rename_variable", &pddlboat::NumericFunction::renameVariable)
.def("get_used_predicates", &pddlboat::NumericFunction::getUsedPredicates)
.def("get_assigned_predicates", &pddlboat::NumericFunction::getAssignedPredicates)
.def("to_id", &pddlboat::NumericFunction::toID)
.def("__repr__", [](const pddlboat::NumericFunction &o){std::stringstream ss; o.toPDDL(ss); return ss.str();})
.def_readwrite("bindings", &pddlboat::NumericFunction::bindings)
;
// Bindings for class pddlboat::Expression::Effect
py::class_<pddlboat::Expression::Effect, std::shared_ptr<pddlboat::Expression::Effect>>(py_pddlboat_Expression, "Effect")
.def("absorb", &pddlboat::Expression::Effect::absorb)
.def("flip", &pddlboat::Expression::Effect::flip)
.def("__repr__", [](const pddlboat::Expression::Effect &o){std::stringstream ss; o.toPDDL(ss); return ss.str();})
.def_readwrite("add", &pddlboat::Expression::Effect::add)
.def_readwrite("remove", &pddlboat::Expression::Effect::remove)
.def_readwrite("assigned", &pddlboat::Expression::Effect::assigned)
;
// Bindings for enum pddlboat::Expression::Type
py::enum_<pddlboat::Expression::Type>(py_pddlboat_Expression, "Type")
.value("EXPRESSION", pddlboat::Expression::Type::EXPRESSION)
.value("PREDICATE", pddlboat::Expression::Type::PREDICATE)
.value("DERIVED", pddlboat::Expression::Type::DERIVED)
.value("AND", pddlboat::Expression::Type::AND)
.value("OR", pddlboat::Expression::Type::OR)
.value("VARIADIC", pddlboat::Expression::Type::VARIADIC)
.value("NOT", pddlboat::Expression::Type::NOT)
.value("EQUALS", pddlboat::Expression::Type::EQUALS)
.value("IMPLY", pddlboat::Expression::Type::IMPLY)
.value("FORALL", pddlboat::Expression::Type::FORALL)
.value("EXISTS", pddlboat::Expression::Type::EXISTS)
.value("QUANTIFIER", pddlboat::Expression::Type::QUANTIFIER)
.value("WHEN", pddlboat::Expression::Type::WHEN)
.value("OBJECT_FUNCTION", pddlboat::Expression::Type::OBJECT_FUNCTION)
.value("NUMERIC_FUNCTION", pddlboat::Expression::Type::NUMERIC_FUNCTION)
.value("GREATER_THAN", pddlboat::Expression::Type::GREATER_THAN)
.value("LESS_THAN", pddlboat::Expression::Type::LESS_THAN)
.value("GREATER_OR_EQUAL", pddlboat::Expression::Type::GREATER_OR_EQUAL)
.value("LESS_OR_EQUAL", pddlboat::Expression::Type::LESS_OR_EQUAL)
.value("MINUS", pddlboat::Expression::Type::MINUS)
.value("DIVIDE", pddlboat::Expression::Type::DIVIDE)
.value("MULTIPLY", pddlboat::Expression::Type::MULTIPLY)
.value("PLUS", pddlboat::Expression::Type::PLUS)
.value("ASSIGN", pddlboat::Expression::Type::ASSIGN)
.value("SCALE_UP", pddlboat::Expression::Type::SCALE_UP)
.value("SCALE_DOWN", pddlboat::Expression::Type::SCALE_DOWN)
.value("INCREASE", pddlboat::Expression::Type::INCREASE)
.value("DECREASE", pddlboat::Expression::Type::DECREASE)
.value("NEXT", pddlboat::Expression::Type::NEXT)
.value("EVENTUALLY", pddlboat::Expression::Type::EVENTUALLY)
.value("ALWAYS", pddlboat::Expression::Type::ALWAYS)
.value("UNTIL", pddlboat::Expression::Type::UNTIL)
.value("RELEASE", pddlboat::Expression::Type::RELEASE)
.export_values()
;
// Bindings for class pddlboat::ObjectFunction
py::class_<pddlboat::ObjectFunction, pddlboat::Expression, std::shared_ptr<pddlboat::ObjectFunction>>(m, "ObjectFunction")
.def(py::init<const pddlboat::ObjectFunctionDefinition *, const std::vector<pddlboat::Value> &>())
.def("get_name", &pddlboat::ObjectFunction::getName)
.def("get_return_type", &pddlboat::ObjectFunction::getReturnType)
.def("get_object", &pddlboat::ObjectFunction::getObject)
.def("type", &pddlboat::ObjectFunction::type)
.def("get_variables", &pddlboat::ObjectFunction::getVariables)
.def("contains_variable", &pddlboat::ObjectFunction::containsVariable)
.def("rename_variable", &pddlboat::ObjectFunction::renameVariable)
.def("get_used_predicates", &pddlboat::ObjectFunction::getUsedPredicates)
.def("get_assigned_predicates", &pddlboat::ObjectFunction::getAssignedPredicates)
.def("get_effects", &pddlboat::ObjectFunction::getEffects)
.def("to_id", &pddlboat::ObjectFunction::toID)
.def("__repr__", [](const pddlboat::ObjectFunction &o){std::stringstream ss; o.toPDDL(ss); return ss.str();})
.def_readwrite("bindings", &pddlboat::ObjectFunction::bindings)
;
// Bindings for class pddlboat::DerivedPredicate
py::class_<pddlboat::DerivedPredicate, pddlboat::Expression, std::shared_ptr<pddlboat::DerivedPredicate>>(m, "DerivedPredicate")
.def(py::init<const pddlboat::DerivedPredicateDefinition *, const std::vector<pddlboat::Value> &>())
.def("arguments", &pddlboat::DerivedPredicate::arguments)
.def("evaluate", &pddlboat::DerivedPredicate::evaluate)
.def("type", &pddlboat::DerivedPredicate::type)
.def("get_variables", &pddlboat::DerivedPredicate::getVariables)
.def("get_used_predicates", &pddlboat::DerivedPredicate::getUsedPredicates)
.def("contains_variable", &pddlboat::DerivedPredicate::containsVariable)
.def("contains_predicate", &pddlboat::DerivedPredicate::containsPredicate)
.def("rename_variable", &pddlboat::DerivedPredicate::renameVariable)
.def("__repr__", [](const pddlboat::DerivedPredicate &o){std::stringstream ss; o.toPDDL(ss); return ss.str();})
.def("name", &pddlboat::DerivedPredicate::name)
.def("to_id", &pddlboat::DerivedPredicate::toID)
.def_readwrite("bindings", &pddlboat::DerivedPredicate::bindings)
;
// Bindings for class pddlboat::Predicate
py::class_<pddlboat::Predicate, pddlboat::Expression, std::shared_ptr<pddlboat::Predicate>>(m, "Predicate")
.def(py::init<const pddlboat::PredicateDefinition *, const std::vector<pddlboat::Value> &>())
.def("arguments", &pddlboat::Predicate::arguments)
.def("evaluate", &pddlboat::Predicate::evaluate)
.def("assign", &pddlboat::Predicate::assign)
.def("type", &pddlboat::Predicate::type)
.def("get_variables", &pddlboat::Predicate::getVariables)
.def("get_used_predicates", &pddlboat::Predicate::getUsedPredicates)
.def("get_assigned_predicates", &pddlboat::Predicate::getAssignedPredicates)
.def("get_effects", &pddlboat::Predicate::getEffects)
.def("contains_variable", &pddlboat::Predicate::containsVariable)
.def("contains_predicate", &pddlboat::Predicate::containsPredicate)
.def("rename_variable", &pddlboat::Predicate::renameVariable)
.def("__repr__", [](const pddlboat::Predicate &o){std::stringstream ss; o.toPDDL(ss); return ss.str();})
.def("to_id", &pddlboat::Predicate::toID)
.def("name", &pddlboat::Predicate::name)
.def("get_definition", &pddlboat::Predicate::getDefinition)
.def_readwrite("bindings", &pddlboat::Predicate::bindings)
;
// Bindings for class pddlboat::GroundedExpression
py::class_<pddlboat::GroundedExpression, std::shared_ptr<pddlboat::GroundedExpression>>(m, "GroundedExpression")
.def(py::init<const std::shared_ptr<pddlboat::Expression> &, const pddlboat::Assignment &>())
.def_readonly("expression", &pddlboat::GroundedExpression::expression)
.def_readonly("assignment", &pddlboat::GroundedExpression::assignment)
;
// Bindings for class pddlboat::GroundedAxiom
py::class_<pddlboat::GroundedAxiom, std::shared_ptr<pddlboat::GroundedAxiom>>(m, "GroundedAxiom")
.def(py::init<const std::shared_ptr<pddlboat::Axiom> &, const pddlboat::Assignment &>())
.def_readonly("axiom", &pddlboat::GroundedAxiom::axiom)
.def_readonly("assignment", &pddlboat::GroundedAxiom::assignment)
;
// Bindings for class pddlboat::GroundedDerivedPredicate
py::class_<pddlboat::GroundedDerivedPredicate, std::shared_ptr<pddlboat::GroundedDerivedPredicate>>(m, "GroundedDerivedPredicate")
.def(py::init<const std::shared_ptr<pddlboat::DerivedPredicateDefinition> &, const pddlboat::Assignment &>())
.def_readonly("derived", &pddlboat::GroundedDerivedPredicate::derived)
.def_readonly("assignment", &pddlboat::GroundedDerivedPredicate::assignment)
.def_readonly("string", &pddlboat::GroundedDerivedPredicate::string)
;
// Bindings for class pddlboat::GroundedNumericFunction
py::class_<pddlboat::GroundedNumericFunction, std::shared_ptr<pddlboat::GroundedNumericFunction>>(m, "GroundedNumericFunction")
.def(py::init<const std::shared_ptr<pddlboat::NumericFunctionDefinition> &, const pddlboat::Assignment &>())
.def_readonly("fluent", &pddlboat::GroundedNumericFunction::fluent)
.def_readonly("assignment", &pddlboat::GroundedNumericFunction::assignment)
.def_readonly("string", &pddlboat::GroundedNumericFunction::string)
;
// Bindings for class pddlboat::GroundedObjectFunction
py::class_<pddlboat::GroundedObjectFunction, std::shared_ptr<pddlboat::GroundedObjectFunction>>(m, "GroundedObjectFunction")
.def(py::init<const std::shared_ptr<pddlboat::ObjectFunctionDefinition> &, const pddlboat::Assignment &>())
.def_readonly("fluent", &pddlboat::GroundedObjectFunction::fluent)
.def_readonly("assignment", &pddlboat::GroundedObjectFunction::assignment)
.def_readonly("string", &pddlboat::GroundedObjectFunction::string)
;
// Bindings for class pddlboat::GroundedFunction
py::class_<pddlboat::GroundedFunction, std::shared_ptr<pddlboat::GroundedFunction>>(m, "GroundedFunction")
.def(py::init<const std::shared_ptr<pddlboat::FunctionDefinition> &, const pddlboat::Assignment &>())
.def_readonly("fluent", &pddlboat::GroundedFunction::fluent)
.def_readonly("assignment", &pddlboat::GroundedFunction::assignment)
.def_readonly("string", &pddlboat::GroundedFunction::string)
;
// Bindings for class pddlboat::GroundedPredicate
py::class_<pddlboat::GroundedPredicate, std::shared_ptr<pddlboat::GroundedPredicate>>(m, "GroundedPredicate")
.def(py::init<const std::shared_ptr<pddlboat::PredicateDefinition> &, const pddlboat::Assignment &>())
.def_readonly("predicate", &pddlboat::GroundedPredicate::predicate)
.def_readonly("assignment", &pddlboat::GroundedPredicate::assignment)
.def_readonly("string", &pddlboat::GroundedPredicate::string)
;
// Bindings for class pddlboat::GroundedAction
py::class_<pddlboat::GroundedAction, std::shared_ptr<pddlboat::GroundedAction>>(m, "GroundedAction")
.def(py::init<const std::shared_ptr<pddlboat::Action> &, const pddlboat::Assignment &>())
.def(py::self == py::self)
.def_readonly("action", &pddlboat::GroundedAction::action)
.def_readonly("assignment", &pddlboat::GroundedAction::assignment)
.def_readonly("string", &pddlboat::GroundedAction::string)
;
// Bindings for class pddlboat::State
py::class_<pddlboat::State, std::shared_ptr<pddlboat::State>>(m, "State")
.def(py::init<const pddlboat::Problem *>())
.def("clone", &pddlboat::State::clone)
.def("clean_clone", &pddlboat::State::cleanClone)
.def("hash", &pddlboat::State::hash)
.def("to_expression", &pddlboat::State::toExpression)
.def("is_equal", static_cast<bool (pddlboat::State::*)(const std::shared_ptr<pddlboat::State> &) const>(&pddlboat::State::isEqual))
.def("is_equal", static_cast<bool (pddlboat::State::*)(const pddlboat::State &) const>(&pddlboat::State::isEqual))
.def("get_objects", &pddlboat::State::getObjects)
.def("strip", &pddlboat::State::strip)
.def("clear", &pddlboat::State::clear)
.def("complement", &pddlboat::State::complement)
.def("fold", static_cast<void (pddlboat::State::*)(const std::shared_ptr<pddlboat::State> &)>(&pddlboat::State::fold))
.def("fold", static_cast<void (pddlboat::State::*)(const pddlboat::State &)>(&pddlboat::State::fold))
.def("clean", &pddlboat::State::clean)
.def("assign0", static_cast<void (pddlboat::State::*)(const std::basic_string<char> &, bool)>(&pddlboat::State::assign0))
.def("assign0", static_cast<void (pddlboat::State::*)(const std::basic_string<char> &, double)>(&pddlboat::State::assign0))
.def("assign0", static_cast<void (pddlboat::State::*)(const std::basic_string<char> &, const std::basic_string<char> &)>(&pddlboat::State::assign0))
.def("assign1", static_cast<void (pddlboat::State::*)(const std::basic_string<char> &, const std::basic_string<char> &, bool)>(&pddlboat::State::assign1))
.def("assign1", static_cast<void (pddlboat::State::*)(const std::basic_string<char> &, const std::basic_string<char> &, double)>(&pddlboat::State::assign1))
.def("assign1", static_cast<void (pddlboat::State::*)(const std::basic_string<char> &, const std::basic_string<char> &, const std::basic_string<char> &)>(&pddlboat::State::assign1))
.def("assign_n", static_cast<void (pddlboat::State::*)(const std::basic_string<char> &, const std::vector<std::basic_string<char>> &, bool)>(&pddlboat::State::assignN))
.def("assign_n", static_cast<void (pddlboat::State::*)(const std::basic_string<char> &, const std::vector<std::basic_string<char>> &, double)>(&pddlboat::State::assignN))
.def("assign_n", static_cast<void (pddlboat::State::*)(const std::basic_string<char> &, const std::vector<std::basic_string<char>> &, const std::basic_string<char> &)>(&pddlboat::State::assignN))
.def("is_true", &pddlboat::State::isTrue)
.def("get_value", &pddlboat::State::getValue)
.def("get_object", &pddlboat::State::getObject)
.def("get_true_predicates", &pddlboat::State::getTruePredicates)
.def("__repr__", [](const pddlboat::State &o){std::stringstream ss; o.toPDDL(ss); return ss.str();})
.def("get_problem", &pddlboat::State::getProblem)
.def("set_problem", &pddlboat::State::setProblem)
.def_readwrite("assignments", &pddlboat::State::assignments)
.def_readwrite("numeric", &pddlboat::State::numeric)
.def_readwrite("values", &pddlboat::State::values)
;
// Bindings for class pddlboat::Problem
py::class_<pddlboat::Problem, std::shared_ptr<pddlboat::Problem>>(m, "Problem")
.def(py::init<const std::basic_string<char> &, const std::shared_ptr<pddlboat::Domain> &>())
.def(py::init<const pddlboat::Problem &>())
.def(py::init<const std::shared_ptr<pddlboat::Problem> &>())
.def(py::init<const std::shared_ptr<pddlboat::State> &>())
.def("get_object", &pddlboat::Problem::getObject)
.def("add_object", static_cast<void (pddlboat::Problem::*)(const std::shared_ptr<pddlboat::Object> &)>(&pddlboat::Problem::addObject))
.def("add_object", static_cast<void (pddlboat::Problem::*)(const std::basic_string<char> &, const std::basic_string<char> &)>(&pddlboat::Problem::addObject))
.def("objects_of_type", &pddlboat::Problem::objectsOfType)
.def("get_groundings", &pddlboat::Problem::getGroundings)
.def("make_state", &pddlboat::Problem::makeState)
.def("axioms_hold", &pddlboat::Problem::axiomsHold)
.def("__repr__", [](const pddlboat::Problem &o){std::stringstream ss; o.toPDDL(ss); return ss.str();})
.def_readonly("name", &pddlboat::Problem::name)
.def_readonly("domain", &pddlboat::Problem::domain)
.def_readwrite("objects", &pddlboat::Problem::objects)
.def_readwrite("start", &pddlboat::Problem::start)
.def_readwrite("goal", &pddlboat::Problem::goal)
.def_readwrite("minimize", &pddlboat::Problem::minimize)
.def_readwrite("metric", &pddlboat::Problem::metric)
;
// Bindings for class pddlboat::Domain
py::class_<pddlboat::Domain, std::shared_ptr<pddlboat::Domain>>(m, "Domain")
.def(py::init<const std::basic_string<char> &>())
.def("add_requirement", &pddlboat::Domain::addRequirement)
.def("clear_requirements", &pddlboat::Domain::clearRequirements)
.def("add_requirements_from_expression", &pddlboat::Domain::addRequirementsFromExpression)
.def("has_requirements", &pddlboat::Domain::hasRequirements)
.def("supports_requirements", &pddlboat::Domain::supportsRequirements)
.def("add_type", &pddlboat::Domain::addType)
.def("get_parent", &pddlboat::Domain::getParent)
.def("get_types", &pddlboat::Domain::getTypes)
.def("is_type", &pddlboat::Domain::isType)
.def("is_type_of", &pddlboat::Domain::isTypeOf)
.def("find_common_type", &pddlboat::Domain::findCommonType)
.def("compare_types", &pddlboat::Domain::compareTypes)
.def("get_constant", &pddlboat::Domain::getConstant)
.def("add_constant", static_cast<void (pddlboat::Domain::*)(const std::shared_ptr<pddlboat::Object> &)>(&pddlboat::Domain::addConstant))
.def("add_constant", static_cast<void (pddlboat::Domain::*)(const std::basic_string<char> &, const std::basic_string<char> &)>(&pddlboat::Domain::addConstant))
.def("add_predicate", &pddlboat::Domain::addPredicate)
.def("remove_predicate", &pddlboat::Domain::removePredicate)
.def("add_derived_predicate", &pddlboat::Domain::addDerivedPredicate)
.def("is_predicate", &pddlboat::Domain::isPredicate)
.def("get_predicate", &pddlboat::Domain::getPredicate)
.def("is_derived_predicate", &pddlboat::Domain::isDerivedPredicate)
.def("get_derived_predicate", &pddlboat::Domain::getDerivedPredicate)
.def("add_function", &pddlboat::Domain::addFunction)
.def("remove_function", &pddlboat::Domain::removeFunction)
.def("is_function", &pddlboat::Domain::isFunction)
.def("is_object_function", &pddlboat::Domain::isObjectFunction)
.def("is_numeric_function", &pddlboat::Domain::isNumericFunction)
.def("get_function", &pddlboat::Domain::getFunction)
.def("get_object_function", &pddlboat::Domain::getObjectFunction)
.def("get_numeric_function", &pddlboat::Domain::getNumericFunction)
.def("add_axiom", &pddlboat::Domain::addAxiom)
.def("add_action", &pddlboat::Domain::addAction)
.def("get_action", &pddlboat::Domain::getAction)
.def("__repr__", [](const pddlboat::Domain &o){std::stringstream ss; o.toPDDL(ss); return ss.str();})
.def_readonly("name", &pddlboat::Domain::name)
.def_readwrite("requirements", &pddlboat::Domain::requirements)
.def_readwrite("types", &pddlboat::Domain::types)
.def_readwrite("constants", &pddlboat::Domain::constants)
.def_readwrite("functions", &pddlboat::Domain::functions)
.def_readwrite("predicates", &pddlboat::Domain::predicates)
.def_readwrite("derived", &pddlboat::Domain::derived)
.def_readwrite("actions", &pddlboat::Domain::actions)
.def_readwrite("axioms", &pddlboat::Domain::axioms)
;
// Bindings for class pddlboat::Axiom
py::class_<pddlboat::Axiom, std::shared_ptr<pddlboat::Axiom>>(m, "Axiom")
.def(py::init<const std::vector<pddlboat::Variable> &, const std::shared_ptr<pddlboat::Expression> &, const std::shared_ptr<pddlboat::Expression> &>())
.def("arity", &pddlboat::Axiom::arity)
.def("relevant", &pddlboat::Axiom::relevant)
.def("holds", &pddlboat::Axiom::holds)
.def("__repr__", [](const pddlboat::Axiom &o){std::stringstream ss; o.toPDDL(ss); return ss.str();})
.def_readonly("parameters", &pddlboat::Axiom::parameters)
.def_readonly("context", &pddlboat::Axiom::context)
.def_readonly("implies", &pddlboat::Axiom::implies)
;
// Bindings for class pddlboat::Action
py::class_<pddlboat::Action, std::shared_ptr<pddlboat::Action>>(m, "Action")
.def(py::init<const std::basic_string<char> &, const std::vector<pddlboat::Variable> &, const std::shared_ptr<pddlboat::Expression> &, const std::shared_ptr<pddlboat::Expression> &>())
.def("arity", &pddlboat::Action::arity)
.def("holds", &pddlboat::Action::holds)
.def("effected", &pddlboat::Action::effected)
.def("do_action", &pddlboat::Action::doAction)
.def("__repr__", [](const pddlboat::Action &o){std::stringstream ss; o.toPDDL(ss); return ss.str();})
.def("to_id", &pddlboat::Action::toID)
.def("to_step_id", &pddlboat::Action::toStepID)
.def_readonly("name", &pddlboat::Action::name)
.def_readonly("parameters", &pddlboat::Action::parameters)
.def_readonly("precondition", &pddlboat::Action::precondition)
.def_readonly("effect", &pddlboat::Action::effect)
;
// Bindings for class pddlboat::FunctionDefinition
py::class_<pddlboat::FunctionDefinition, std::shared_ptr<pddlboat::FunctionDefinition>>(m, "FunctionDefinition")
.def(py::init<const std::basic_string<char> &, const std::vector<pddlboat::Variable> &, const std::basic_string<char> &>())
.def("is_valid_assignment", &pddlboat::FunctionDefinition::isValidAssignment)
.def("arity", &pddlboat::FunctionDefinition::arity)
.def("__repr__", [](const pddlboat::FunctionDefinition &o){std::stringstream ss; o.toPDDL(ss); return ss.str();})
.def("to_id", &pddlboat::FunctionDefinition::toID)
.def_readonly("name", &pddlboat::FunctionDefinition::name)
.def_readonly("parameters", &pddlboat::FunctionDefinition::parameters)
.def_readonly("type", &pddlboat::FunctionDefinition::type)
;
// Bindings for class pddlboat::ObjectFunctionDefinition
py::class_<pddlboat::ObjectFunctionDefinition, pddlboat::FunctionDefinition, std::shared_ptr<pddlboat::ObjectFunctionDefinition>>(m, "ObjectFunctionDefinition")
.def(py::init<const std::basic_string<char> &, const std::vector<pddlboat::Variable> &, const std::basic_string<char> &>())
.def("bind", static_cast<std::shared_ptr<pddlboat::ObjectFunction> (pddlboat::ObjectFunctionDefinition::*)() const>(&pddlboat::ObjectFunctionDefinition::bind))
.def("bind", static_cast<std::shared_ptr<pddlboat::ObjectFunction> (pddlboat::ObjectFunctionDefinition::*)(const std::vector<std::basic_string<char>> &) const>(&pddlboat::ObjectFunctionDefinition::bind))
.def("bind", static_cast<std::shared_ptr<pddlboat::ObjectFunction> (pddlboat::ObjectFunctionDefinition::*)(const std::vector<std::basic_string<char>> &, const std::shared_ptr<pddlboat::Problem> &) const>(&pddlboat::ObjectFunctionDefinition::bind))
.def("bind_values", &pddlboat::ObjectFunctionDefinition::bindValues)
;
// Bindings for class pddlboat::NumericFunctionDefinition
py::class_<pddlboat::NumericFunctionDefinition, pddlboat::FunctionDefinition, std::shared_ptr<pddlboat::NumericFunctionDefinition>>(m, "NumericFunctionDefinition")
.def(py::init<const std::basic_string<char> &, const std::vector<pddlboat::Variable> &>())
.def("bind", static_cast<std::shared_ptr<pddlboat::NumericFunction> (pddlboat::NumericFunctionDefinition::*)() const>(&pddlboat::NumericFunctionDefinition::bind))
.def("bind", static_cast<std::shared_ptr<pddlboat::NumericFunction> (pddlboat::NumericFunctionDefinition::*)(const std::vector<std::basic_string<char>> &, const std::shared_ptr<pddlboat::Problem> &, const std::shared_ptr<pddlboat::Domain> &) const>(&pddlboat::NumericFunctionDefinition::bind))
.def("bind_values", &pddlboat::NumericFunctionDefinition::bindValues)
;
// Bindings for class pddlboat::DerivedPredicateDefinition
py::class_<pddlboat::DerivedPredicateDefinition, std::shared_ptr<pddlboat::DerivedPredicateDefinition>>(m, "DerivedPredicateDefinition")
.def(py::init<const std::basic_string<char> &, const std::vector<pddlboat::Variable> &, const std::shared_ptr<pddlboat::Expression> &>())
.def("set_formula", &pddlboat::DerivedPredicateDefinition::setFormula)
.def("bind", static_cast<std::shared_ptr<pddlboat::DerivedPredicate> (pddlboat::DerivedPredicateDefinition::*)() const>(&pddlboat::DerivedPredicateDefinition::bind))
.def("bind", static_cast<std::shared_ptr<pddlboat::DerivedPredicate> (pddlboat::DerivedPredicateDefinition::*)(const std::vector<std::basic_string<char>> &) const>(&pddlboat::DerivedPredicateDefinition::bind))
.def("bind", static_cast<std::shared_ptr<pddlboat::DerivedPredicate> (pddlboat::DerivedPredicateDefinition::*)(const std::vector<std::basic_string<char>> &, const std::shared_ptr<pddlboat::Problem> &, const std::shared_ptr<pddlboat::Domain> &) const>(&pddlboat::DerivedPredicateDefinition::bind))
.def("bind_values", &pddlboat::DerivedPredicateDefinition::bindValues)
.def("is_valid_assignment", &pddlboat::DerivedPredicateDefinition::isValidAssignment)
.def("arity", &pddlboat::DerivedPredicateDefinition::arity)
.def("__repr__", [](const pddlboat::DerivedPredicateDefinition &o){std::stringstream ss; o.toPDDL(ss); return ss.str();})
.def("to_id", &pddlboat::DerivedPredicateDefinition::toID)
.def_readonly("name", &pddlboat::DerivedPredicateDefinition::name)
.def_readonly("parameters", &pddlboat::DerivedPredicateDefinition::parameters)
.def_readwrite("expression", &pddlboat::DerivedPredicateDefinition::expression)
;
// Bindings for class pddlboat::PredicateDefinition
py::class_<pddlboat::PredicateDefinition, std::shared_ptr<pddlboat::PredicateDefinition>>(m, "PredicateDefinition")
.def(py::init<const std::basic_string<char> &, const std::vector<pddlboat::Variable> &>())
.def("bind", static_cast<std::shared_ptr<pddlboat::Predicate> (pddlboat::PredicateDefinition::*)(const std::vector<std::basic_string<char>> &) const>(&pddlboat::PredicateDefinition::bind))
.def("bind", static_cast<std::shared_ptr<pddlboat::Predicate> (pddlboat::PredicateDefinition::*)(const std::vector<std::basic_string<char>> &, const pddlboat::Problem &) const>(&pddlboat::PredicateDefinition::bind))
.def("bind_values", &pddlboat::PredicateDefinition::bindValues)
.def("is_valid_assignment", &pddlboat::PredicateDefinition::isValidAssignment)
.def("arity", &pddlboat::PredicateDefinition::arity)
.def("__repr__", [](const pddlboat::PredicateDefinition &o){std::stringstream ss; o.toPDDL(ss); return ss.str();})
.def("to_id", &pddlboat::PredicateDefinition::toID)
.def_readonly("name", &pddlboat::PredicateDefinition::name)
.def_readonly("variables", &pddlboat::PredicateDefinition::variables)
;
// Bindings for class pddlboat::Assignment
py::class_<pddlboat::Assignment, std::shared_ptr<pddlboat::Assignment>>(m, "Assignment")
.def(py::init())
.def(py::init<const pddlboat::Assignment &>())
.def("fold", &pddlboat::Assignment::fold)
.def("arity", &pddlboat::Assignment::arity)
.def("assign", &pddlboat::Assignment::assign)
.def("type", &pddlboat::Assignment::type)
.def("typed", &pddlboat::Assignment::typed)
.def("unassign", &pddlboat::Assignment::unassign)
.def("assigned", &pddlboat::Assignment::assigned)
.def("is_assigned", &pddlboat::Assignment::isAssigned)
.def("get_variables", &pddlboat::Assignment::getVariables)
.def("__repr__", [](const pddlboat::Assignment &o){std::stringstream ss; o.toString(ss); return ss.str();})
.def_readwrite("var_to_obj", &pddlboat::Assignment::varToObj)
.def_readwrite("var_to_type", &pddlboat::Assignment::varToType)
;
// Bindings for class pddlboat::PlanDependencyGraph
py::class_<pddlboat::PlanDependencyGraph, std::shared_ptr<pddlboat::PlanDependencyGraph>> py_pddlboat_PlanDependencyGraph(m, "PlanDependencyGraph");
py_pddlboat_PlanDependencyGraph.def(py::init<const pddlboat::Plan &>())
.def(py::init<const std::shared_ptr<pddlboat::Plan> &>())
.def(py::init<const pddlboat::PlanDependencyGraph &>())
.def("initialize", &pddlboat::PlanDependencyGraph::initialize)
.def("get_plan_step", &pddlboat::PlanDependencyGraph::getPlanStep)
.def("get_nodes", &pddlboat::PlanDependencyGraph::getNodes)
.def("remove_node", &pddlboat::PlanDependencyGraph::removeNode)
.def("compute_node_states", &pddlboat::PlanDependencyGraph::computeNodeStates)
.def("is_parent", &pddlboat::PlanDependencyGraph::isParent)
.def("is_child", &pddlboat::PlanDependencyGraph::isChild)
.def("is_descendant", &pddlboat::PlanDependencyGraph::isDescendant)
.def("is_ancestor", &pddlboat::PlanDependencyGraph::isAncestor)
.def("get_predecessors", &pddlboat::PlanDependencyGraph::getPredecessors)
.def("get_descendants", &pddlboat::PlanDependencyGraph::getDescendants)
.def("get_parents", &pddlboat::PlanDependencyGraph::getParents)
.def("get_children", &pddlboat::PlanDependencyGraph::getChildren)
.def("get_nodes_with_makespan", &pddlboat::PlanDependencyGraph::getNodesWithMakespan)
.def("get_nodes_with_greater_makespan", &pddlboat::PlanDependencyGraph::getNodesWithGreaterMakespan)
.def("get_nodes_with_less_makespan", &pddlboat::PlanDependencyGraph::getNodesWithLessMakespan)
.def("get_nodes_by_makespan", &pddlboat::PlanDependencyGraph::getNodesByMakespan)
.def("get_max_makespan", &pddlboat::PlanDependencyGraph::getMaxMakespan)
.def("get_nodes_with_leaf_distance", &pddlboat::PlanDependencyGraph::getNodesWithLeafDistance)
.def("get_nodes_with_greater_leaf_distance", &pddlboat::PlanDependencyGraph::getNodesWithGreaterLeafDistance)
.def("get_nodes_with_less_leaf_distance", &pddlboat::PlanDependencyGraph::getNodesWithLessLeafDistance)
.def("get_nodes_by_leaf_distance", &pddlboat::PlanDependencyGraph::getNodesByLeafDistance)
.def("get_leafs", &pddlboat::PlanDependencyGraph::getLeafs)
.def("get_max_leaf_distance", &pddlboat::PlanDependencyGraph::getMaxLeafDistance)
.def("__repr__", [](const pddlboat::PlanDependencyGraph &o){std::stringstream ss; o.toDotFile(ss); return ss.str();})
;
// Bindings for class pddlboat::PlanDependencyGraph::DotFileOptions
py::class_<pddlboat::PlanDependencyGraph::DotFileOptions, std::shared_ptr<pddlboat::PlanDependencyGraph::DotFileOptions>> py_pddlboat_PlanDependencyGraph_DotFileOptions(py_pddlboat_PlanDependencyGraph, "DotFileOptions");
py_pddlboat_PlanDependencyGraph_DotFileOptions.def(py::init())
.def_readwrite("ranking", &pddlboat::PlanDependencyGraph::DotFileOptions::ranking)
.def_readwrite("action", &pddlboat::PlanDependencyGraph::DotFileOptions::action)
.def_readwrite("index", &pddlboat::PlanDependencyGraph::DotFileOptions::index)
.def_readwrite("color_leafs", &pddlboat::PlanDependencyGraph::DotFileOptions::colorLeafs)
.def_readwrite("color_terminals", &pddlboat::PlanDependencyGraph::DotFileOptions::colorTerminals)
.def_readwrite("state_tool_tips", &pddlboat::PlanDependencyGraph::DotFileOptions::stateToolTips)
.def_readwrite("edge_tool_tips", &pddlboat::PlanDependencyGraph::DotFileOptions::edgeToolTips)
.def_readwrite("draw_start", &pddlboat::PlanDependencyGraph::DotFileOptions::drawStart)
.def_readwrite("draw_end", &pddlboat::PlanDependencyGraph::DotFileOptions::drawEnd)
;
// Bindings for enum pddlboat::PlanDependencyGraph::DotFileOptions::Rank
py::enum_<pddlboat::PlanDependencyGraph::DotFileOptions::Rank>(py_pddlboat_PlanDependencyGraph_DotFileOptions, "Rank")
.value("MAKESPAN", pddlboat::PlanDependencyGraph::DotFileOptions::Rank::MAKESPAN)
.value("LEAFDIST", pddlboat::PlanDependencyGraph::DotFileOptions::Rank::LEAFDIST)
.export_values()
;
// Bindings for class pddlboat::PlanDependencyGraph::ActionNode
py::class_<pddlboat::PlanDependencyGraph::ActionNode, std::shared_ptr<pddlboat::PlanDependencyGraph::ActionNode>>(py_pddlboat_PlanDependencyGraph, "ActionNode")
.def("is_effected", &pddlboat::PlanDependencyGraph::ActionNode::isEffected)
.def("is_prior", &pddlboat::PlanDependencyGraph::ActionNode::isPrior)
.def("get_interaction", &pddlboat::PlanDependencyGraph::ActionNode::getInteraction)
.def("__repr__", [](const pddlboat::PlanDependencyGraph::ActionNode &o){std::stringstream ss; o.toString(ss); return ss.str();})
.def_readonly("action", &pddlboat::PlanDependencyGraph::ActionNode::action)
.def_readonly("assignment", &pddlboat::PlanDependencyGraph::ActionNode::assignment)
.def_readonly("plan_index", &pddlboat::PlanDependencyGraph::ActionNode::plan_index)
.def_readonly("pre_pred", &pddlboat::PlanDependencyGraph::ActionNode::pre_pred)
.def_readonly("eff_pred", &pddlboat::PlanDependencyGraph::ActionNode::eff_pred)
.def_readwrite("pre_state", &pddlboat::PlanDependencyGraph::ActionNode::pre_state)
.def_readwrite("eff_state", &pddlboat::PlanDependencyGraph::ActionNode::eff_state)
.def_readwrite("makespan", &pddlboat::PlanDependencyGraph::ActionNode::makespan)
.def_readwrite("leafdist", &pddlboat::PlanDependencyGraph::ActionNode::leafdist)
;
// Bindings for class pddlboat::ast::z3Predicate
py::class_<pddlboat::ast::z3Predicate, std::shared_ptr<pddlboat::ast::z3Predicate>>(ast_m, "z3Predicate")
.def("__repr__", [](const pddlboat::ast::z3Predicate &o){std::stringstream ss; o.toPDDL(ss); return ss.str();})
.def_readwrite("name", &pddlboat::ast::z3Predicate::name)
.def_readwrite("args", &pddlboat::ast::z3Predicate::args)
.def_readwrite("time", &pddlboat::ast::z3Predicate::time)
.def_readwrite("conv", &pddlboat::ast::z3Predicate::conv)
;
// Bindings for class pddlboat::ast::z3Action
py::class_<pddlboat::ast::z3Action, std::shared_ptr<pddlboat::ast::z3Action>>(ast_m, "z3Action")
.def("__repr__", [](const pddlboat::ast::z3Action &o){std::stringstream ss; o.toPDDL(ss); return ss.str();})
.def_readwrite("name", &pddlboat::ast::z3Action::name)
.def_readwrite("args", &pddlboat::ast::z3Action::args)
.def_readwrite("time", &pddlboat::ast::z3Action::time)
.def_readwrite("conv", &pddlboat::ast::z3Action::conv)
;
// Bindings for class pddlboat::ast::Plan
py::class_<pddlboat::ast::Plan, std::shared_ptr<pddlboat::ast::Plan>>(ast_m, "Plan")
.def("__repr__", [](const pddlboat::ast::Plan &o){std::stringstream ss; o.toString(ss); return ss.str();})
.def_readwrite("actions", &pddlboat::ast::Plan::actions)
;
// Bindings for class pddlboat::ast::Problem
py::class_<pddlboat::ast::Problem, std::shared_ptr<pddlboat::ast::Problem>>(ast_m, "Problem")
.def("__repr__", [](const pddlboat::ast::Problem &o){std::stringstream ss; o.toString(ss); return ss.str();})
.def_readwrite("name", &pddlboat::ast::Problem::name)
.def_readwrite("domain", &pddlboat::ast::Problem::domain)
.def_readwrite("objects", &pddlboat::ast::Problem::objects)
.def_readwrite("initial", &pddlboat::ast::Problem::initial)
.def_readwrite("goal", &pddlboat::ast::Problem::goal)
.def_readwrite("metric", &pddlboat::ast::Problem::metric)
;
// Bindings for class pddlboat::ast::Metric
py::class_<pddlboat::ast::Metric, std::shared_ptr<pddlboat::ast::Metric>>(ast_m, "Metric")
.def_readwrite("active", &pddlboat::ast::Metric::active)
.def_readwrite("minimize", &pddlboat::ast::Metric::minimize)
.def_readwrite("function", &pddlboat::ast::Metric::function)
;
// Bindings for class pddlboat::ast::Initial
py::class_<pddlboat::ast::Initial, std::shared_ptr<pddlboat::ast::Initial>>(ast_m, "Initial")
.def("__repr__", [](const pddlboat::ast::Initial &o){std::stringstream ss; o.toString(ss); return ss.str();})
.def_readwrite("formula", &pddlboat::ast::Initial::formula)
.def_readwrite("set", &pddlboat::ast::Initial::set)
.def_readwrite("object", &pddlboat::ast::Initial::object)
;
// Bindings for class pddlboat::ast::Domain
py::class_<pddlboat::ast::Domain, std::shared_ptr<pddlboat::ast::Domain>>(ast_m, "Domain")
.def("__repr__", [](const pddlboat::ast::Domain &o){std::stringstream ss; o.toString(ss); return ss.str();})
.def_readwrite("name", &pddlboat::ast::Domain::name)
.def_readwrite("requirements", &pddlboat::ast::Domain::requirements)
.def_readwrite("types", &pddlboat::ast::Domain::types)
.def_readwrite("constants", &pddlboat::ast::Domain::constants)
.def_readwrite("predicates", &pddlboat::ast::Domain::predicates)
.def_readwrite("functions", &pddlboat::ast::Domain::functions)
.def_readwrite("actions", &pddlboat::ast::Domain::actions)
;
// Bindings for class pddlboat::ast::Action
py::class_<pddlboat::ast::Action, std::shared_ptr<pddlboat::ast::Action>>(ast_m, "Action")
.def("__repr__", [](const pddlboat::ast::Action &o){std::stringstream ss; o.toString(ss); return ss.str();})
.def_readwrite("derived", &pddlboat::ast::Action::derived)
.def_readwrite("name", &pddlboat::ast::Action::name)
.def_readwrite("parameters", &pddlboat::ast::Action::parameters)
.def_readwrite("precondition", &pddlboat::ast::Action::precondition)
.def_readwrite("effect", &pddlboat::ast::Action::effect)
;
// Bindings for class pddlboat::ast::Expression
py::class_<pddlboat::ast::Expression, std::shared_ptr<pddlboat::ast::Expression>>(ast_m, "Expression")
.def(py::init())
.def(py::init<const std::basic_string<char> &>())
.def(py::init<const std::basic_string<char> &, const std::vector<pddlboat::ast::Expression> &>())
.def(py::init<const std::basic_string<char> &, const std::vector<pddlboat::ast::TypedList> &, const std::vector<pddlboat::ast::Expression> &>())
.def("__repr__", [](const pddlboat::ast::Expression &o){std::stringstream ss; o.toString(ss); return ss.str();})
.def("get_keyword", &pddlboat::ast::Expression::getKeyword)
.def_readwrite("op", &pddlboat::ast::Expression::op)
.def_readwrite("parameters", &pddlboat::ast::Expression::parameters)
.def_readwrite("terms", &pddlboat::ast::Expression::terms)
.def_readwrite("number", &pddlboat::ast::Expression::number)
;
// Bindings for class pddlboat::ast::AtomicFormulaList
py::class_<pddlboat::ast::AtomicFormulaList, std::shared_ptr<pddlboat::ast::AtomicFormulaList>>(ast_m, "AtomicFormulaList")
.def("__repr__", [](const pddlboat::ast::AtomicFormulaList &o){std::stringstream ss; o.toString(ss); return ss.str();})
.def_readwrite("formulas", &pddlboat::ast::AtomicFormulaList::formulas)
.def_readwrite("parent", &pddlboat::ast::AtomicFormulaList::parent)
;
// Bindings for class pddlboat::ast::AtomicFormula
py::class_<pddlboat::ast::AtomicFormula, std::shared_ptr<pddlboat::ast::AtomicFormula>>(ast_m, "AtomicFormula")
.def("__repr__", [](const pddlboat::ast::AtomicFormula &o){std::stringstream ss; o.toString(ss); return ss.str();})
.def_readwrite("name", &pddlboat::ast::AtomicFormula::name)
.def_readwrite("variables", &pddlboat::ast::AtomicFormula::variables)
;
// Bindings for class pddlboat::ast::TypedList
py::class_<pddlboat::ast::TypedList, std::shared_ptr<pddlboat::ast::TypedList>>(ast_m, "TypedList")
.def("__repr__", [](const pddlboat::ast::TypedList &o){std::stringstream ss; o.toString(ss); return ss.str();})
.def_readwrite("types", &pddlboat::ast::TypedList::types)
.def_readwrite("parent", &pddlboat::ast::TypedList::parent)
;
// Bindings for class pddlboat::ast::Term
py::class_<pddlboat::ast::Term, std::shared_ptr<pddlboat::ast::Term>>(ast_m, "Term")
.def_readwrite("symbol", &pddlboat::ast::Term::symbol)
.def_readwrite("terms", &pddlboat::ast::Term::terms)
;
m
.def("parse_file", static_cast<bool (*)(const std::basic_string<char> &, pddlboat::ast::Domain &)>(&pddlboat::parseFile))
.def("parse_file", static_cast<bool (*)(const std::basic_string<char> &, pddlboat::ast::Problem &)>(&pddlboat::parseFile))
.def("parse_file", static_cast<bool (*)(const std::basic_string<char> &, pddlboat::ast::Plan &)>(&pddlboat::parseFile))
.def("parse_file", static_cast<bool (*)(const std::basic_string<char> &, pddlboat::ast::Expression &)>(&pddlboat::parseFile))
;
m
.def("parse_string", static_cast<bool (*)(const std::basic_string<char> &, pddlboat::ast::Domain &)>(&pddlboat::parseString))
.def("parse_string", static_cast<bool (*)(const std::basic_string<char> &, pddlboat::ast::Problem &)>(&pddlboat::parseString))
.def("parse_string", static_cast<bool (*)(const std::basic_string<char> &, pddlboat::ast::Plan &)>(&pddlboat::parseString))
.def("parse_string", static_cast<bool (*)(const std::basic_string<char> &, pddlboat::ast::Expression &)>(&pddlboat::parseString))
.def("parse_string", static_cast<bool (*)(const std::basic_string<char> &, std::vector<pddlboat::ast::TypedList> &)>(&pddlboat::parseString))
;
m.def("parse_z3_action", &pddlboat::parseZ3Action);
m.def("parse_z3_predicate", &pddlboat::parseZ3Predicate);
m.def("get_variables", &pddlboat::getVariables);
m.def("to_expression", &pddlboat::toExpression);
m.def("to_action", &pddlboat::toAction);
m.def("to_derived", &pddlboat::toDerived);
m.def("to_axiom", &pddlboat::toAxiom);
m.def("to_domain", &pddlboat::toDomain);
m.def("to_problem", &pddlboat::toProblem);
m.def("parse_domain", &pddlboat::parseDomain);
m.def("parse_problem", &pddlboat::parseProblem);
m.def("parse_expression", &pddlboat::parseExpression);
m.def("make_pred", &pddlboat::makePred);
m.def("make_derived_pred", &pddlboat::makeDerivedPred);
m.def("make_function", &pddlboat::makeFunction);
m.def("make_object_function", &pddlboat::makeObjectFunction);
m.def("make_action", &pddlboat::makeAction);
m.def("make_no_op_action", &pddlboat::makeNoOpAction);
m.def("make_axiom", &pddlboat::makeAxiom);
m.def("is_in", &pddlboat::isIn);
m.def("get_value_objects", &pddlboat::getValueObjects);
m.def("get_value", &pddlboat::getValue);
m
.def("get_values", static_cast<std::vector<pddlboat::Value> (*)(const std::vector<std::basic_string<char>> &, const std::vector<pddlboat::Variable> &, const std::shared_ptr<pddlboat::Problem> &, const std::shared_ptr<pddlboat::Domain> &)>(&pddlboat::getValues))
.def("get_values", static_cast<std::vector<pddlboat::Value> (*)(const std::vector<std::basic_string<char>> &, const std::vector<pddlboat::Variable> &, const pddlboat::Problem *, const pddlboat::Domain *)>(&pddlboat::getValues))
;
m.def("make_and", &pddlboat::makeAnd);
m.def("make_or", &pddlboat::makeOr);
m.def("make_not", &pddlboat::makeNot);
m.def("make_imply", &pddlboat::makeImply);
m.def("make_when", &pddlboat::makeWhen);
m.def("make_exists", &pddlboat::makeExists);
m.def("make_forall", &pddlboat::makeForall);
m.def("make_equals", &pddlboat::makeEquals);
m.def("make_greater_than", &pddlboat::makeGreaterThan);
m.def("make_less_than", &pddlboat::makeLessThan);
m.def("make_greater_or_equal", &pddlboat::makeGreaterOrEqual);
m.def("make_less_or_equal", &pddlboat::makeLessOrEqual);
m.def("make_minus", &pddlboat::makeMinus);
m.def("make_divide", &pddlboat::makeDivide);
m.def("make_multiply", &pddlboat::makeMultiply);
m.def("make_plus", &pddlboat::makePlus);
m
.def("make_assign", static_cast<std::shared_ptr<pddlboat::AssignObject> (*)(const std::shared_ptr<pddlboat::ObjectFunction> &, const pddlboat::Value &)>(&pddlboat::makeAssign))
.def("make_assign", static_cast<std::shared_ptr<pddlboat::AssignNumber> (*)(const std::shared_ptr<pddlboat::NumericFunction> &, const std::shared_ptr<pddlboat::NumericExpression> &)>(&pddlboat::makeAssign))
.def("make_assign", static_cast<std::shared_ptr<pddlboat::AssignNumber> (*)(const std::shared_ptr<pddlboat::NumericFunction> &, double)>(&pddlboat::makeAssign))
;
m
.def("make_scale_up", static_cast<std::shared_ptr<pddlboat::ScaleUp> (*)(const std::shared_ptr<pddlboat::NumericFunction> &, const std::shared_ptr<pddlboat::NumericExpression> &)>(&pddlboat::makeScaleUp))
.def("make_scale_up", static_cast<std::shared_ptr<pddlboat::ScaleUp> (*)(const std::shared_ptr<pddlboat::NumericFunction> &, double)>(&pddlboat::makeScaleUp))
;
m
.def("make_scale_down", static_cast<std::shared_ptr<pddlboat::ScaleDown> (*)(const std::shared_ptr<pddlboat::NumericFunction> &, const std::shared_ptr<pddlboat::NumericExpression> &)>(&pddlboat::makeScaleDown))
.def("make_scale_down", static_cast<std::shared_ptr<pddlboat::ScaleDown> (*)(const std::shared_ptr<pddlboat::NumericFunction> &, double)>(&pddlboat::makeScaleDown))
;
m
.def("make_increase", static_cast<std::shared_ptr<pddlboat::Increase> (*)(const std::shared_ptr<pddlboat::NumericFunction> &, const std::shared_ptr<pddlboat::NumericExpression> &)>(&pddlboat::makeIncrease))
.def("make_increase", static_cast<std::shared_ptr<pddlboat::Increase> (*)(const std::shared_ptr<pddlboat::NumericFunction> &, double)>(&pddlboat::makeIncrease))
;
m
.def("make_decrease", static_cast<std::shared_ptr<pddlboat::Decrease> (*)(const std::shared_ptr<pddlboat::NumericFunction> &, const std::shared_ptr<pddlboat::NumericExpression> &)>(&pddlboat::makeDecrease))
.def("make_decrease", static_cast<std::shared_ptr<pddlboat::Decrease> (*)(const std::shared_ptr<pddlboat::NumericFunction> &, double)>(&pddlboat::makeDecrease))
;
m.def("make_obj", &pddlboat::makeObj);
}
