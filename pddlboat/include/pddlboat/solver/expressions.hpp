#ifndef PDDLBOAT_EXPRESSIONS_
#define PDDLBOAT_EXPRESSIONS_

#include <iostream>
#include <memory>
#include <string>
#include <vector>
#include <set>
#include <map>
#include <type_traits>

#include <pddlboat/macros.hpp>
#include <pddlboat/solver/expression.hpp>
#include <pddlboat/solver/domain.hpp>

namespace pddlboat
{
    ///
    /// Variadic Expression
    ///

    PDDLBOAT_CLASS_FORWARD(VariadicExpression)
    class VariadicExpression : public Expression
    {
    public:
        VariadicExpression();
        VariadicExpression(const std::vector<ExpressionPtr> &terms);

        void addTerm(const ExpressionPtr &expression);
        std::vector<ExpressionPtr> getTerms() const;

        Expression::Type type() const override;
        Expression::Type getTypes() const override;
        void getVariables(VariableSet &vars) const override;

        void getUsedPredicates(std::set<std::string> &predicates, const StatePtr &state,
                               const Assignment &vars) const override;
        void getAssignedPredicates(std::set<std::string> &predicates, const StatePtr &state,
                                   const Assignment &vars) const override;
        void getEffects(Effect &effect, const StatePtr &state, const Assignment &vars) const override;
        bool containsVariable(const std::string &variable) const override;
        bool containsPredicate(const std::string &predicate) const override;
        void renameVariable(const std::string &old, const std::string &name) override;

        void getAtomicPropsMap(std::map<std::string, std::pair<std::string, std::vector<std::string>>> &pred_mapping) const override;

    protected:
        std::vector<ExpressionPtr> terms_;
    };

    template <typename T>
    ExpressionPtr makeCAR(const std::shared_ptr<T> &expr)
    {
        static_assert(std::is_base_of<VariadicExpression, T>::value, "T must be a descendant of "
                                                                     "VariadicExpression");

        return expr->getTerms().front();
    }

    template <typename T>
    std::shared_ptr<T> makeCDR(const std::shared_ptr<T> &expr)
    {
        static_assert(std::is_base_of<VariadicExpression, T>::value, "T must be a descendant of "
                                                                     "VariadicExpression");

        const auto &terms = expr->getTerms();

        if (terms.size() > 1)
        {
            auto cdr = std::make_shared<T>();
            for (unsigned int i = 1; i < terms.size(); ++i)
                cdr->addTerm(terms[i]);

            return cdr;
        }

        return nullptr;
    }

    ///
    /// And
    ///

    PDDLBOAT_CLASS_FORWARD(And)
    class And : public VariadicExpression
    {
    public:
        And(const std::vector<ExpressionPtr> &terms = {});

        bool evaluate(const StatePtr &state, const Assignment &vars) const override;
        void assign(StatePtr &out, const StatePtr &in, const Assignment &vars) const override;
        Expression::Type type() const override;
        std::ostream &toPDDL(std::ostream &out, unsigned int indent = 2,
                             unsigned int level = 0) const override;
        std::string toLTL() const override;
    };

    AndPtr makeAnd(const std::vector<ExpressionPtr> &terms);

    ///
    /// Or
    ///

    PDDLBOAT_CLASS_FORWARD(Or)
    class Or : public VariadicExpression
    {
    public:
        Or(const std::vector<ExpressionPtr> &terms = {});

        bool evaluate(const StatePtr &state, const Assignment &vars) const override;
        Expression::Type type() const override;
        std::ostream &toPDDL(std::ostream &out, unsigned int indent = 2,
                             unsigned int level = 0) const override;
        std::string toLTL() const override;
    };

    OrPtr makeOr(const std::vector<ExpressionPtr> &terms);

    ///
    /// Not
    ///

    PDDLBOAT_CLASS_FORWARD(Not)
    class Not : public Expression
    {
    public:
        Not(const ExpressionPtr &term);

        const ExpressionPtr getTerm() const;

        bool evaluate(const StatePtr &state, const Assignment &vars) const override;
        void assign(StatePtr &out, const StatePtr &in, const Assignment &vars) const override;
        Expression::Type type() const override;
        Expression::Type getTypes() const override;
        void getVariables(VariableSet &vars) const override;
        void getUsedPredicates(std::set<std::string> &predicates, const StatePtr &state,
                               const Assignment &vars) const override;
        void getAssignedPredicates(std::set<std::string> &predicates, const StatePtr &state,
                                   const Assignment &vars) const override;
        void getEffects(Effect &effect, const StatePtr &state, const Assignment &vars) const override;
        bool containsVariable(const std::string &variable) const override;
        bool containsPredicate(const std::string &predicate) const override;
        void renameVariable(const std::string &old, const std::string &name) override;

        std::ostream &toPDDL(std::ostream &out, unsigned int indent = 2,
                             unsigned int level = 0) const override;
        std::string toLTL() const override;      
        void getAtomicPropsMap(std::map<std::string, std::pair<std::string, std::vector<std::string>>> &pred_mapping) const override;            

    private:
        const ExpressionPtr term_;
    };

    NotPtr makeNot(const ExpressionPtr &term);

    ///
    /// Imply
    ///

    PDDLBOAT_CLASS_FORWARD(Imply)
    class Imply : public Expression
    {
    public:
        Imply(const ExpressionPtr &left, const ExpressionPtr &right);

        const ExpressionPtr getLeft() const;
        const ExpressionPtr getRight() const;

        bool evaluate(const StatePtr &state, const Assignment &vars) const override;
        Expression::Type type() const override;
        Expression::Type getTypes() const override;

        void getUsedPredicates(std::set<std::string> &predicates, const StatePtr &state,
                               const Assignment &vars) const override;
        void getVariables(VariableSet &vars) const override;
        bool containsVariable(const std::string &variable) const override;
        bool containsPredicate(const std::string &predicate) const override;
        void renameVariable(const std::string &old, const std::string &name) override;

        std::ostream &toPDDL(std::ostream &out, unsigned int indent = 2,
                             unsigned int level = 0) const override;
        std::string toLTL() const override;
        void getAtomicPropsMap(std::map<std::string, std::pair<std::string, std::vector<std::string>>> &pred_mapping) const override;

    private:
        const ExpressionPtr left_, right_;
    };

    ImplyPtr makeImply(const ExpressionPtr &left, const ExpressionPtr &right);

    ///
    /// When
    ///

    PDDLBOAT_CLASS_FORWARD(When)
    class When : public Expression
    {
    public:
        When(const ExpressionPtr &left, const ExpressionPtr &right);

        const ExpressionPtr getLeft() const;
        const ExpressionPtr getRight() const;

        bool evaluate(const StatePtr &state, const Assignment &vars) const override;
        void assign(StatePtr &out, const StatePtr &in, const Assignment &vars) const override;
        Expression::Type type() const override;
        Expression::Type getTypes() const override;

        void getVariables(VariableSet &vars) const override;
        void getUsedPredicates(std::set<std::string> &predicates, const StatePtr &state,
                               const Assignment &vars) const override;
        void getAssignedPredicates(std::set<std::string> &predicates, const StatePtr &state,
                                   const Assignment &vars) const override;
        void getEffects(Effect &effect, const StatePtr &state, const Assignment &vars) const override;
        bool containsVariable(const std::string &variable) const override;
        bool containsPredicate(const std::string &predicate) const override;
        void renameVariable(const std::string &old, const std::string &name) override;

        std::ostream &toPDDL(std::ostream &out, unsigned int indent = 2,
                             unsigned int level = 0) const override;

    private:
        const ExpressionPtr left_, right_;
    };

    WhenPtr makeWhen(const ExpressionPtr &left, const ExpressionPtr &right);

    ///
    /// QuantifierExpression
    ///

    PDDLBOAT_CLASS_FORWARD(QuantifierExpression)
    class QuantifierExpression : public Expression
    {
    public:
        QuantifierExpression(const VariableSet &domain, const ExpressionPtr &formula);

        const VariableList &getDomain() const;
        const ExpressionPtr &getFormula() const;

        Expression::Type type() const override;
        Expression::Type getTypes() const override;
        void getUsedPredicates(std::set<std::string> &predicates, const StatePtr &state,
                               const Assignment &vars) const override;
        void getVariables(VariableSet &vars) const override;
        bool containsVariable(const std::string &variable) const override;
        bool containsPredicate(const std::string &predicate) const override;
        void renameVariable(const std::string &old, const std::string &name) override;

    protected:
        VariableList domain_;
        ExpressionPtr formula_;
    };

    ///
    /// Exists
    ///

    PDDLBOAT_CLASS_FORWARD(Exists)
    class Exists : public QuantifierExpression
    {
    public:
        Exists(const VariableSet &domain, const ExpressionPtr &formula);

        bool evaluate(const StatePtr &state, const Assignment &vars) const override;
        // void assign(StatePtr &out, const Assignment &vars) const override;
        Expression::Type type() const override;
        std::ostream &toPDDL(std::ostream &out, unsigned int indent = 2,
                             unsigned int level = 0) const override;
    };

    ExistsPtr makeExists(const VariableSet &domain, const ExpressionPtr &formula);

    ///
    /// Forall
    ///

    PDDLBOAT_CLASS_FORWARD(Forall)
    class Forall : public QuantifierExpression
    {
    public:
        Forall(const VariableSet &domain, const ExpressionPtr &formula);

        bool evaluate(const StatePtr &state, const Assignment &vars) const override;
        void assign(StatePtr &out, const StatePtr &in, const Assignment &vars) const override;
        void getAssignedPredicates(std::set<std::string> &predicates, const StatePtr &state,
                                   const Assignment &vars) const override;
        void getEffects(Effect &effect, const StatePtr &state, const Assignment &vars) const override;
        Expression::Type type() const override;
        std::ostream &toPDDL(std::ostream &out, unsigned int indent = 2,
                             unsigned int level = 0) const override;
    };

    ForallPtr makeForall(const VariableSet &domain, const ExpressionPtr &formula);

    ///
    /// Equals
    ///

    PDDLBOAT_CLASS_FORWARD(Equals)
    class Equals : public Expression
    {
    public:
        Equals(const Value &term1, const Value &term2);

        std::pair<Value, Value> getTerms() const;

        void assign(StatePtr &out, const StatePtr &in, const Assignment &vars) const override;
        bool evaluate(const StatePtr &state, const Assignment &vars) const override;
        Expression::Type type() const override;
        Expression::Type getTypes() const override;
        void getUsedPredicates(std::set<std::string> &predicates, const StatePtr &state,
                               const Assignment &vars) const override;
        void getAssignedPredicates(std::set<std::string> &predicates, const StatePtr &state,
                                   const Assignment &vars) const override;
        void getEffects(Effect &effect, const StatePtr &state, const Assignment &vars) const override;
        void getVariables(VariableSet &vars) const override;
        bool containsVariable(const std::string &variable) const override;
        bool containsPredicate(const std::string &predicate) const override;
        void renameVariable(const std::string &old, const std::string &name) override;
        std::ostream &toPDDL(std::ostream &out, unsigned int indent = 2,
                             unsigned int level = 0) const override;

    private:
        Value term1_;
        Value term2_;
    };

    EqualsPtr makeEquals(const Value &term1, const Value &term2);

    ///
    /// Binary Op
    ///

    class BinaryExpression : public NumericExpression
    {
    public:
        BinaryExpression(const NumericExpressionPtr &lhs, const NumericExpressionPtr &rhs);

        const NumericExpressionPtr &getLHS() const;
        const NumericExpressionPtr &getRHS() const;

        Type getTypes() const override;
        void getVariables(VariableSet &vars) const override;
        void getUsedPredicates(std::set<std::string> &predicates, const StatePtr &state,
                               const Assignment &vars) const override;
        bool containsVariable(const std::string &variable) const override;
        bool containsPredicate(const std::string &predicate) const override;
        void renameVariable(const std::string &old, const std::string &name) override;
        std::ostream &toPDDL(std::ostream &out, unsigned int indent = 2,
                             unsigned int level = 0) const override;

    protected:
        const NumericExpressionPtr lhs_;
        const NumericExpressionPtr rhs_;
    };

    ///
    /// Greater Than
    ///

    PDDLBOAT_CLASS_FORWARD(GreaterThan)
    class GreaterThan : public BinaryExpression
    {
    public:
        GreaterThan(const NumericExpressionPtr &lhs, const NumericExpressionPtr &rhs);
        Expression::Type type() const override;
        bool evaluate(const StatePtr &state, const Assignment &vars) const override;
    };

    GreaterThanPtr makeGreaterThan(const NumericExpressionPtr &lhs, const NumericExpressionPtr &rhs);

    ///
    /// Less Than
    ///

    PDDLBOAT_CLASS_FORWARD(LessThan)
    class LessThan : public BinaryExpression
    {
    public:
        LessThan(const NumericExpressionPtr &lhs, const NumericExpressionPtr &rhs);
        Expression::Type type() const override;
        bool evaluate(const StatePtr &state, const Assignment &vars) const override;
    };

    LessThanPtr makeLessThan(const NumericExpressionPtr &lhs, const NumericExpressionPtr &rhs);

    ///
    /// Greater Or Equal
    ///

    PDDLBOAT_CLASS_FORWARD(GreaterOrEqual)
    class GreaterOrEqual : public BinaryExpression
    {
    public:
        GreaterOrEqual(const NumericExpressionPtr &lhs, const NumericExpressionPtr &rhs);
        Expression::Type type() const override;
        bool evaluate(const StatePtr &state, const Assignment &vars) const override;
    };

    GreaterOrEqualPtr makeGreaterOrEqual(const NumericExpressionPtr &lhs, const NumericExpressionPtr &rhs);

    ///
    /// Less Or Equal
    ///

    PDDLBOAT_CLASS_FORWARD(LessOrEqual)
    class LessOrEqual : public BinaryExpression
    {
    public:
        LessOrEqual(const NumericExpressionPtr &lhs, const NumericExpressionPtr &rhs);
        Expression::Type type() const override;
        bool evaluate(const StatePtr &state, const Assignment &vars) const override;
    };

    LessOrEqualPtr makeLessOrEqual(const NumericExpressionPtr &lhs, const NumericExpressionPtr &rhs);

    ///
    /// Minus
    ///

    PDDLBOAT_CLASS_FORWARD(Minus)
    class Minus : public BinaryExpression
    {
    public:
        Minus(const NumericExpressionPtr &lhs, const NumericExpressionPtr &rhs);
        Expression::Type type() const override;
        double getValue(const StatePtr &state, const Assignment &vars) const override;
    };

    MinusPtr makeMinus(const NumericExpressionPtr &lhs, const NumericExpressionPtr &rhs);

    ///
    /// Divide
    ///

    PDDLBOAT_CLASS_FORWARD(Divide)
    class Divide : public BinaryExpression
    {
    public:
        Divide(const NumericExpressionPtr &lhs, const NumericExpressionPtr &rhs);
        Expression::Type type() const override;
        double getValue(const StatePtr &state, const Assignment &vars) const override;
    };

    DividePtr makeDivide(const NumericExpressionPtr &lhs, const NumericExpressionPtr &rhs);

    ///
    /// Multiply
    ///

    PDDLBOAT_CLASS_FORWARD(Multiply)
    class Multiply : public BinaryExpression
    {
    public:
        Multiply(const NumericExpressionPtr &lhs, const NumericExpressionPtr &rhs);
        Expression::Type type() const override;
        double getValue(const StatePtr &state, const Assignment &vars) const override;
    };

    MultiplyPtr makeMultiply(const NumericExpressionPtr &lhs, const NumericExpressionPtr &rhs);

    ///
    /// Plus
    ///

    PDDLBOAT_CLASS_FORWARD(Plus)
    class Plus : public BinaryExpression
    {
    public:
        Plus(const NumericExpressionPtr &lhs, const NumericExpressionPtr &rhs);
        Expression::Type type() const override;
        double getValue(const StatePtr &state, const Assignment &vars) const override;
    };

    PlusPtr makePlus(const NumericExpressionPtr &lhs, const NumericExpressionPtr &rhs);

    ///
    /// Assign
    ///

    PDDLBOAT_CLASS_FORWARD(AssignObject)
    class AssignObject : public Expression
    {
    public:
        AssignObject(const ObjectFunctionPtr &lhs, const Value &rhs);

        void assign(StatePtr &out, const StatePtr &in, const Assignment &vars) const override;
        Type type() const override;
        void getVariables(VariableSet &vars) const override;
        void getUsedPredicates(std::set<std::string> &predicates, const StatePtr &state,
                               const Assignment &vars) const override;
        void getAssignedPredicates(std::set<std::string> &predicates, const StatePtr &state,
                                   const Assignment &vars) const override;
        bool containsVariable(const std::string &variable) const override;
        void renameVariable(const std::string &old, const std::string &name) override;
        std::ostream &toPDDL(std::ostream &out, unsigned int indent = 2,
                             unsigned int level = 0) const override;

    private:
        ObjectFunctionPtr lhs_;
        Value rhs_;
    };

    AssignObjectPtr makeAssign(const ObjectFunctionPtr &lhs, const Value &rhs);

    PDDLBOAT_CLASS_FORWARD(AssignNumber)
    class AssignNumber : public Expression
    {
    public:
        AssignNumber(const NumericFunctionPtr &lhs, const NumericExpressionPtr &rhs);
        AssignNumber(const NumericFunctionPtr &lhs, double rhs);

        double getLHSValue(const StatePtr &in, const Assignment &vars) const;
        virtual double getRHSValue(const StatePtr &in, const Assignment &vars) const;

        const NumericFunctionPtr &getLHS() const;
        const NumericExpressionPtr &getRHS() const;

        void assign(StatePtr &out, const StatePtr &in, const Assignment &vars) const override;
        Type type() const override;
        void getVariables(VariableSet &vars) const override;
        void getUsedPredicates(std::set<std::string> &predicates, const StatePtr &state,
                               const Assignment &vars) const override;
        void getAssignedPredicates(std::set<std::string> &predicates, const StatePtr &state,
                                   const Assignment &vars) const override;
        bool containsVariable(const std::string &variable) const override;
        void renameVariable(const std::string &old, const std::string &name) override;
        std::ostream &toPDDL(std::ostream &out, unsigned int indent = 2,
                             unsigned int level = 0) const override;

    protected:
        NumericFunctionPtr lhs_;
        NumericExpressionPtr rhs_{nullptr};
        double constant_{0};
    };

    AssignNumberPtr makeAssign(const NumericFunctionPtr &lhs, const NumericExpressionPtr &rhs);
    AssignNumberPtr makeAssign(const NumericFunctionPtr &lhs, double rhs);

    ///
    /// Scale Up
    ///

    PDDLBOAT_CLASS_FORWARD(ScaleUp)
    class ScaleUp : public AssignNumber
    {
    public:
        ScaleUp(const NumericFunctionPtr &lhs, const NumericExpressionPtr &rhs);
        ScaleUp(const NumericFunctionPtr &lhs, double rhs);

        Type type() const override;
        double getRHSValue(const StatePtr &in, const Assignment &vars) const override;
    };

    ScaleUpPtr makeScaleUp(const NumericFunctionPtr &lhs, const NumericExpressionPtr &rhs);
    ScaleUpPtr makeScaleUp(const NumericFunctionPtr &lhs, double rhs);

    ///
    /// Scale Down
    ///

    PDDLBOAT_CLASS_FORWARD(ScaleDown)
    class ScaleDown : public AssignNumber
    {
    public:
        ScaleDown(const NumericFunctionPtr &lhs, const NumericExpressionPtr &rhs);
        ScaleDown(const NumericFunctionPtr &lhs, double rhs);

        Type type() const override;
        double getRHSValue(const StatePtr &in, const Assignment &vars) const override;
    };

    ScaleDownPtr makeScaleDown(const NumericFunctionPtr &lhs, const NumericExpressionPtr &rhs);
    ScaleDownPtr makeScaleDown(const NumericFunctionPtr &lhs, double rhs);

    ///
    /// Increase
    ///

    PDDLBOAT_CLASS_FORWARD(Increase)
    class Increase : public AssignNumber
    {
    public:
        Increase(const NumericFunctionPtr &lhs, const NumericExpressionPtr &rhs);
        Increase(const NumericFunctionPtr &lhs, double rhs);

        Type type() const override;
        double getRHSValue(const StatePtr &in, const Assignment &vars) const override;
    };

    IncreasePtr makeIncrease(const NumericFunctionPtr &lhs, const NumericExpressionPtr &rhs);
    IncreasePtr makeIncrease(const NumericFunctionPtr &lhs, double rhs);

    ///
    /// Decrease
    ///

    PDDLBOAT_CLASS_FORWARD(Decrease)
    class Decrease : public AssignNumber
    {
    public:
        Decrease(const NumericFunctionPtr &lhs, const NumericExpressionPtr &rhs);
        Decrease(const NumericFunctionPtr &lhs, double rhs);

        Type type() const override;
        double getRHSValue(const StatePtr &in, const Assignment &vars) const override;
    };

    DecreasePtr makeDecrease(const NumericFunctionPtr &lhs, const NumericExpressionPtr &rhs);
    DecreasePtr makeDecrease(const NumericFunctionPtr &lhs, double rhs);


    ///
    /// Next
    ///

    PDDLBOAT_CLASS_FORWARD(Next)
    class Next : public Expression
    {
    public:
        Next(const ExpressionPtr &term);

        const ExpressionPtr getTerm() const;

        bool evaluate(const StatePtr &state, const Assignment &vars) const override;
        Expression::Type type() const override;
        Expression::Type getTypes() const override;
        void getVariables(VariableSet &vars) const override;
        void getUsedPredicates(std::set<std::string> &predicates, const StatePtr &state,
                               const Assignment &vars) const override;
        void getAssignedPredicates(std::set<std::string> &predicates, const StatePtr &state,
                                   const Assignment &vars) const override;
        bool containsVariable(const std::string &variable) const override;
        bool containsPredicate(const std::string &predicate) const override;
        void renameVariable(const std::string &old, const std::string &name) override;

        std::ostream &toPDDL(std::ostream &out, unsigned int indent = 2,
                             unsigned int level = 0) const override;
        std::string toLTL() const override;
        void getAtomicPropsMap(std::map<std::string, std::pair<std::string, std::vector<std::string>>> &pred_mapping) const override;

    private:
        const ExpressionPtr term_;
    };

    NextPtr makeNext(const ExpressionPtr &term);

    ///
    /// Eventually
    ///

    PDDLBOAT_CLASS_FORWARD(Eventually)
    class Eventually : public Expression
    {
    public:
        Eventually(const ExpressionPtr &term);

        const ExpressionPtr getTerm() const;

        bool evaluate(const StatePtr &state, const Assignment &vars) const override;
        Expression::Type type() const override;
        Expression::Type getTypes() const override;
        void getVariables(VariableSet &vars) const override;
        void getUsedPredicates(std::set<std::string> &predicates, const StatePtr &state,
                               const Assignment &vars) const override;
        void getAssignedPredicates(std::set<std::string> &predicates, const StatePtr &state,
                                   const Assignment &vars) const override;
        bool containsVariable(const std::string &variable) const override;
        bool containsPredicate(const std::string &predicate) const override;
        void renameVariable(const std::string &old, const std::string &name) override;

        std::ostream &toPDDL(std::ostream &out, unsigned int indent = 2,
                             unsigned int level = 0) const override;
        std::string toLTL() const override;

        void getAtomicPropsMap(std::map<std::string, std::pair<std::string, std::vector<std::string>>> &pred_mapping) const override;

    private:
        const ExpressionPtr term_;
    };

    EventuallyPtr makeEventually(const ExpressionPtr &term);

    ///
    /// Always
    ///

    PDDLBOAT_CLASS_FORWARD(Always)
    class Always : public Expression
    {
    public:
        Always(const ExpressionPtr &term);

        const ExpressionPtr getTerm() const;

        bool evaluate(const StatePtr &state, const Assignment &vars) const override;
        Expression::Type type() const override;
        Expression::Type getTypes() const override;
        void getVariables(VariableSet &vars) const override;
        void getUsedPredicates(std::set<std::string> &predicates, const StatePtr &state,
                               const Assignment &vars) const override;
        void getAssignedPredicates(std::set<std::string> &predicates, const StatePtr &state,
                                   const Assignment &vars) const override;
        bool containsVariable(const std::string &variable) const override;
        bool containsPredicate(const std::string &predicate) const override;
        void renameVariable(const std::string &old, const std::string &name) override;

        std::ostream &toPDDL(std::ostream &out, unsigned int indent = 2,
                             unsigned int level = 0) const override;
        std::string toLTL() const override;

        void getAtomicPropsMap(std::map<std::string, std::pair<std::string, std::vector<std::string>>> &pred_mapping) const override;

    private:
        const ExpressionPtr term_;
    };

    AlwaysPtr makeAlways(const ExpressionPtr &term);

    ///
    /// Until
    ///

    PDDLBOAT_CLASS_FORWARD(Until)
    class Until : public Expression
    {
    public:
        Until(const ExpressionPtr &left, const ExpressionPtr &right);

        const ExpressionPtr getLeft() const;
        const ExpressionPtr getRight() const;

        bool evaluate(const StatePtr &state, const Assignment &vars) const override;
        Expression::Type type() const override;
        Expression::Type getTypes() const override;

        void getUsedPredicates(std::set<std::string> &predicates, const StatePtr &state,
                               const Assignment &vars) const override;
        void getVariables(VariableSet &vars) const override;
        bool containsVariable(const std::string &variable) const override;
        bool containsPredicate(const std::string &predicate) const override;
        void renameVariable(const std::string &old, const std::string &name) override;

        std::ostream &toPDDL(std::ostream &out, unsigned int indent = 2,
                             unsigned int level = 0) const override;
        std::string toLTL() const override;
        void getAtomicPropsMap(std::map<std::string, std::pair<std::string, std::vector<std::string>>> &pred_mapping) const override;

    private:
        const ExpressionPtr left_, right_;
    };

    UntilPtr makeUntil(const ExpressionPtr &left, const ExpressionPtr &right);

    ///
    /// Release
    ///

    PDDLBOAT_CLASS_FORWARD(Release)
    class Release : public Expression
    {
    public:
        Release(const ExpressionPtr &left, const ExpressionPtr &right);

        const ExpressionPtr getLeft() const;
        const ExpressionPtr getRight() const;

        bool evaluate(const StatePtr &state, const Assignment &vars) const override;
        Expression::Type type() const override;
        Expression::Type getTypes() const override;

        void getUsedPredicates(std::set<std::string> &predicates, const StatePtr &state,
                               const Assignment &vars) const override;
        void getVariables(VariableSet &vars) const override;
        bool containsVariable(const std::string &variable) const override;
        bool containsPredicate(const std::string &predicate) const override;
        void renameVariable(const std::string &old, const std::string &name) override;

        std::ostream &toPDDL(std::ostream &out, unsigned int indent = 2,
                             unsigned int level = 0) const override;
        std::string toLTL() const override;
        void getAtomicPropsMap(std::map<std::string, std::pair<std::string, std::vector<std::string>>> &pred_mapping) const override;

    private:
        const ExpressionPtr left_, right_;
    };

    ReleasePtr makeRelease(const ExpressionPtr &left, const ExpressionPtr &right);
}  // namespace pddlboat

#endif
