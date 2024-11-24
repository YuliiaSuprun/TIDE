/* Author: Zachary Kingston */

#include <fstream>
#include <sstream>
#include <iostream>

#include <pddlboat/utility.hpp>
#include <pddlboat/parser/parser.hpp>
#include <pddlboat/solver/fdplanner.hpp>

using namespace pddlboat;

const std::string FastDownwardPlanner::FastDownwardPlanner::fd_directory = io::getResourceDirectory(
    PDDLBOAT_FASTDOWNWARD_LOCATION);  ///< Directory where the fast downward binary resides

FastDownwardPlanner::FastDownwardPlanner(const ProblemPtr &problem, const Options &options)
  : Planner(problem)
  , uuid(io::generateUUID())
  , domain_file(temporary + "/" + log::format(domain_file_template, uuid))
  , problem_file(temporary + "/" + log::format(problem_file_template, uuid))
  , sas_file(temporary + "/" + log::format(sas_file_template, uuid))
  , output_filename(log::format(output_file_template, uuid))
  , output_file(temporary + "/" + output_filename)
  , options(options)
{
    checkRequirements();
}

FastDownwardPlanner::~FastDownwardPlanner()
{
    io::deleteFile(domain_file);
    io::deleteFile(problem_file);
    io::deleteFile(sas_file);

    // Fast downward sometimes generates multiple output files as it refines its search
    auto matches = io::glob(temporary, output_filename + ".*");
    if (matches)
    {
        for (const auto &match : *matches) {
            io::deleteFile(match);
        }
    }
}

Requirements::Keyword FastDownwardPlanner::getSupportedRequirements() const
{
    auto reqs = Requirements::ADL | Requirements::ACTION_COSTS;
    if (options.search != Search::ASTAR)
        reqs = reqs | Requirements::DERIVED_PREDICATES;
    return reqs;
}

std::string FastDownwardPlanner::generateSolverCommand() const
{
    std::stringstream cs;
    cs << *solver;

    // Output file
    cs << " --internal-plan-file " << output_file;

    // See http://www.fast-downward.org/PlannerUsage for more
    // Also, the aliases.py file in the driver provided with fast downward
    switch (options.search)
    {
        case Search::ASTAR:
            cs << " --internal-plan-file " << output_file;
            // std::cout << "Search::ASTAR is used" << std::endl;
            // A* with landmark cut heuristic
            cs << " --search \"astar(lmcut())\"";
            break;

        case Search::LAZYGREEDY:
            // std::cout << "Search::LAZYGREEDY is used" << std::endl;
            // Lazy greedy best-first search with preferred operators and the queue alternation method
            // using FF heuristic and context-enhanced additive heuristic
            cs << " --evaluator \"hff=ff()\"";
            cs << " --evaluator \"hcea=cea()\"";
            cs << " --search \"lazy_greedy([hff, hcea], preferred=[hff, hcea])\"";
            break;

        case Search::FDAT:
            // std::cout << "Search::FDAT is used" << std::endl;
            // Fast Downward Autotune 2
            cs << " --evaluator \"hcea=cea(transform=adapt_costs(plusone))\"";
            cs << " --evaluator \"hcg=cg(transform=adapt_costs(one))\"";
            cs << " --evaluator \"hgc=goalcount(transform=adapt_costs(plusone))\"";
            cs << " --evaluator \"hff=ff()\"";

            cs << " --search ";
            cs << "\"";
            cs << "iterated([";
            cs << "ehc(hcea,preferred=[hcea],preferred_usage=0,cost_type=normal),";
            cs << "lazy(alt([single(sum([weight(g(),2),weight(hff,3)])),";
            cs << "single(sum([weight(g(),2),weight(hff,3)]),pref_only=true),";
            cs << "single(sum([weight(g(),2),weight(hcg,3)])),";
            cs << "single(sum([weight(g(),2),weight(hcg,3)]),pref_only=true),";
            cs << "single(sum([weight(g(),2),weight(hcea,3)])),";
            cs << "single(sum([weight(g(),2),weight(hcea,3)]),pref_only=true),";
            cs << "single(sum([weight(g(),2),weight(hgc,3)])),";
            cs << "single(sum([weight(g(),2),weight(hgc,3)]),pref_only=true)],";
            cs << "boost=200),";
            cs << "preferred=[hcea,hgc],reopen_closed=false,cost_type=one),";
            cs << "lazy(alt([single(sum([g(),weight(hff,5)])),";
            cs << "single(sum([g(),weight(hff,5)]),pref_only=true),";
            cs << "single(sum([g(),weight(hcg,5)])),";
            cs << "single(sum([g(),weight(hcg,5)]),pref_only=true),";
            cs << "single(sum([g(),weight(hcea,5)])),";
            cs << "single(sum([g(),weight(hcea,5)]),pref_only=true),";
            cs << "single(sum([g(),weight(hgc,5)])),";
            cs << "single(sum([g(),weight(hgc,5)]),pref_only=true)],";
            cs << "boost=5000),";
            cs << "preferred=[hcea,hgc],reopen_closed=true,cost_type=normal),";
            cs << "lazy(alt([single(sum([g(),weight(hff,2)])),";
            cs << "single(sum([g(),weight(hff,2)]),pref_only=true),";
            cs << "single(sum([g(),weight(hcg,2)])),";
            cs << "single(sum([g(),weight(hcg,2)]),pref_only=true),";
            cs << "single(sum([g(),weight(hcea,2)])),";
            cs << "single(sum([g(),weight(hcea,2)]),pref_only=true),";
            cs << "single(sum([g(),weight(hgc,2)])),";
            cs << "single(sum([g(),weight(hgc,2)]),pref_only=true)],";
            cs << "boost=1000),";
            cs << "preferred=[hcea,hgc],reopen_closed=true,cost_type=one)";
            cs << "],repeat_last=true,continue_on_fail=true)";
            cs << "\"";
            break;

        case Search::LAMA:
            // std::cout << "Search::LAMA is used" << std::endl;
            // cs << " --alias seq-sat-lama-2011 ";
            cs << " --search ";
            cs << " --if-unit-cost ";
            cs << "\"let(hlm, landmark_sum(lm_reasonable_orders_hps(lm_rhw()),pref=true),";
            cs << "let(hff, ff(),iterated([";
            cs << "lazy_greedy([hff,hlm],preferred=[hff,hlm]),";
            cs << "lazy_wastar([hff,hlm],preferred=[hff,hlm],w=5),";
            cs << "lazy_wastar([hff,hlm],preferred=[hff,hlm],w=3),";
            cs << "lazy_wastar([hff,hlm],preferred=[hff,hlm],w=2),";
            cs << "lazy_wastar([hff,hlm],preferred=[hff,hlm],w=1)";
            cs << "],repeat_last=true,continue_on_fail=true)))\" ";
            
            cs << "--if-non-unit-cost ";
            cs << "\"let(hlm1, landmark_sum(lm_reasonable_orders_hps(lm_rhw()),transform=adapt_costs(one),pref=true),";
            cs << "let(hff1, ff(transform=adapt_costs(one)),";
            cs << "let(hlm2, landmark_sum(lm_reasonable_orders_hps(lm_rhw()),transform=adapt_costs(plusone),pref=true),";
            cs << "let(hff2, ff(transform=adapt_costs(plusone)),iterated([";
            cs << "lazy_greedy([hff1,hlm1],preferred=[hff1,hlm1],cost_type=one,reopen_closed=false),";
            cs << "lazy_greedy([hff2,hlm2],preferred=[hff2,hlm2],reopen_closed=false),";
            cs << "lazy_wastar([hff2,hlm2],preferred=[hff2,hlm2],w=5),";
            cs << "lazy_wastar([hff2,hlm2],preferred=[hff2,hlm2],w=3),";
            cs << "lazy_wastar([hff2,hlm2],preferred=[hff2,hlm2],w=2),";
            cs << "lazy_wastar([hff2,hlm2],preferred=[hff2,hlm2],w=1)";
            cs << "],repeat_last=true,continue_on_fail=true)))))\" ";
            
            cs << "--always";
            
            break;
        case Search::LAMA_FIRST:
            // --search 'let(hlm,landmark_sum(lm_factory=lm_reasonable_orders_hps(lm_rhw()),transform=adapt_costs(one),pref=false),let(hff,ff(transform=adapt_costs(one)),lazy_greedy([hff,hlm],preferred=[hff,hlm],cost_type=one,reopen_closed=false)))'
            // cs << " --alias lama-first ";
            cs << " --search ";
            cs << "\"let(hlm, landmark_sum(lm_factory=lm_reasonable_orders_hps(lm_rhw()),transform=adapt_costs(one),pref=false),";
            cs << "let(hff, ff(transform=adapt_costs(one)),";
            cs << "lazy_greedy([hff,hlm],preferred=[hff,hlm],cost_type=one,reopen_closed=false)))\" ";
            
            break;
    }

    // Tell command what SAS file to use
    cs << " < " << sas_file;

    return cs.str();
}

std::string FastDownwardPlanner::generateTranslatorCommand() const
{
    std::stringstream ts;
    ts << *translator;
    if (options.no_simplify_sas)
    {
        ts << " --keep-unreachable-facts";
        ts << " --keep-unimportant-variables";
    }
    ts << " --sas-file " << sas_file << " " << domain_file << " " << problem_file;

    return ts.str();
}

void FastDownwardPlanner::update(bool domain, bool problem)
{
    boost::timer::cpu_timer timer;

    // Serialize problem and domain
    if (domain)
    {
        std::ofstream domain_out;
        io::createFile(domain_out, domain_file);

        // Log domain file creation
        if (!domain_out) {
            std::cerr << "Failed to create domain file: " << domain_file << std::endl;
            throw std::runtime_error("Failed to create domain file.");
        }

        problem_->domain->toPDDL(domain_out);
        domain_out.flush();
        domain_out.close();
    }

    if (problem)
    {
        std::ofstream problem_out;
        io::createFile(problem_out, problem_file);
        // Log problem file creation
        if (!problem_out) {
            std::cerr << "Failed to create problem file: " << problem_file << std::endl;
            throw std::runtime_error("Failed to create problem file.");
        }
        problem_->toPDDL(problem_out);
        problem_out.flush();
        problem_out.close();
    }

    if (domain or problem)
    {
        // Call translator
        auto tr = io::runCommand(getTranslatorCommand());

        if (tr == std::nullopt) {
            throw std::runtime_error("Failed to translate problem and domain!");
        }
        if (!preprocess()) {
            throw std::runtime_error("Failed to preprocess problem and domain!");
        }
    }

    translator_time = io::getElapsedMilliseconds(timer) / 1000.;
}

bool FastDownwardPlanner::solve(Plan &plan)
{
    return solve(plan, 0);
}

bool FastDownwardPlanner::solve(Plan &plan, unsigned int timeout)
{
    if (not translator_command)
        // This signifies that we haven't run update() ever
        update();

    boost::timer::cpu_timer timer;

    // Platform-specific timeout command
    std::string timeout_cmd = "timeout";

    auto cmd = log::format(timeout_cmd + " %1$0.3f ", timeout / 1000.) + getSolverCommand();
    auto output = io::runCommand(cmd);
    if (output == std::nullopt) {
        std::cerr << "Failed to execute solver command!" << std::endl;
        return false;
    }
    // Parse output file
    ast::Plan parsed;
    auto matches = io::glob(temporary, output_filename + ".*");
    if (matches)
    {
        auto files = *matches;
        std::sort(files.begin(), files.end());

        if (files.empty()) {
            // std::cerr << "No matching files found." << std::endl;
            return false;
        }

        auto file = files.back();
        parseFile(file, parsed);

        for (const auto &action : parsed.actions)
        {
            std::vector<std::string> objects;
            for (const auto &tl : action.variables)
                for (const auto &t : tl.types)
                    objects.emplace_back(t);

            plan.addStep(action.name, objects);
        }
    } 

    plan.setTimeTaken("translate", *translator_time);
    plan.setTimeTaken("solve", io::getElapsedMilliseconds(timer) / 1000.);
    return plan.validate();
}

const std::string &FastDownwardPlanner::getDirectory() const
{
    return fd_directory;
}

std::string FastDownwardPlanner::getSolver()
{
    return io::resolvePath(log::format("%1%/downward", getDirectory()));
}

const std::string &FastDownwardPlanner::getSolverCommand()
{
    if (not solver_command)
    {
        if (not solver)
        {
            solver = getSolver();
        }

        solver_command = generateSolverCommand();
    }

    return *solver_command;
}

const std::string &FastDownwardPlanner::getTranslatorCommand()
{
    if (not translator_command)
    {
        if (not translator)
        {
            translator = io::resolvePath(log::format("%1%/translate/translate.py", getDirectory()));
        }

        translator_command = generateTranslatorCommand();
    }

    return *translator_command;
}

bool FastDownwardPlanner::preprocess() const
{
    return true;
}
