#ifndef LTL_FORMULA_H
#define LTL_FORMULA_H

#include <string>
#include <map>
#include <set>
#include <iostream>
#include <algorithm>
#include <regex>

#include <spot/tl/formula.hh>
#include <spot/tl/parse.hh>
#include <spot/tl/print.hh>
#include "DomainState.h"

using namespace std;

/*
Documentation on using SPOT for LTLf formulas: 
https://spot.lre.epita.fr/tut12.html

General Approach:
1. Have Spot read the input LTLf formula as if it was LTL.
2. Rewrite this formula in a way that embeds the semantics of LTLf in LTL.
First, introduce a new atomic proposition alive that will be true initially,
but that will eventually become false forever. Then adjust all original LTL
operators so that they have to be satisfied during the alive part of the word.
For instance the formula (a U b) & Fc would be transformed into alive & (a U (alive & b)) & F(alive & c) & (alive U G!alive).
3. Convert the resulting formula into a Büchi automaton
4. Remove the alive property, after marking as accepting all states with
an outgoing edge labeled by !alive.
(Note that since Spot does not actually support state-based acceptance,
it needs to keep a false self-loop on any accepting state without a successor
in order to mark it as accepting.)
5. Interpret the above automaton as finite automaton.
*/


class LTLFormula {
public:
    LTLFormula(const string& formula, 
               const map<string, DomainStateSet>&ap_to_states_mapping)
        : formula_(formula), ap_to_states_mapping_(ap_to_states_mapping), use_pred_mapping_(false) {}
    
    LTLFormula(const string& formula, 
               const map<string, pair<string, vector<string>>>& pred_mapping)
        : use_pred_mapping_(true) {
            // Check if the character '-' is in the formula 
            // (SPOT doesn't like it for some reason)
            formula_ = remove_dashes(formula);
            for (const auto& prop_pair : pred_mapping) {
                pred_mapping_.insert({remove_dashes(prop_pair.first), prop_pair.second});
            }
        }
    
    // Default constructor
    LTLFormula() : formula_(""), ap_to_states_mapping_(), use_pred_mapping_(false) {}

    string get_formula() const { return formula_; }
    map<string, DomainStateSet> get_ap_to_states_mapping() const {
        if (use_pred_mapping_) {
            cerr << "ERROR: the pred_mapping has to be used." << endl;
        }
        return ap_to_states_mapping_; 
    }

    map<string, pair<string, vector<string>>> get_pred_mapping() const {
        if (!use_pred_mapping_) {
            cerr << "ERROR: the ap_to_states_mapping has to be used." << endl;
        }
        return pred_mapping_; 
    }

    // Function to return Spot's formula
    spot::formula get_spot_formula() const {
        // cout << "LTLf Formula: " << formula_ << endl;
        spot::parsed_formula pf = spot::parse_infix_psl(formula_);
        // Here, we could also handle any parsing errors.
        // Handle any parsing errors
        if (pf.format_errors(std::cerr)) {
            std::cerr << "Error parsing the formula: " << formula_ << std::endl;
            return spot::formula(); // Return an empty formula in case of error
        }
        // Dump the formula for debugging
        // pf.f.dump(std::cout);
        // std::cout << std::endl;
        // cout << "spot formula: " << pf.f << endl;
        return pf.f;
    }

    // Overloading the << operator.
    friend ostream& operator<<(ostream& os, const LTLFormula& ltlFormula);

    // Additional utility methods can be added as required

private:
    string formula_;
    map<string, DomainStateSet> ap_to_states_mapping_;
    map<string, pair<string, vector<string>>> pred_mapping_;
    bool use_pred_mapping_;

    string remove_dashes(string str) {
        std::replace(str.begin(), str.end(), '-', '_');
        // Replace "_>" with "->" using regex for "imply"
        str = std::regex_replace(str, std::regex("_>"), "->");
        return str;
    }
};

// Definition of the overloaded << operator for LTLFormula
inline ostream& operator<<(ostream& os, const LTLFormula& ltlFormula) {
    os << ltlFormula.formula_;
    return os;
}

#endif // LTL_FORMULA_H
