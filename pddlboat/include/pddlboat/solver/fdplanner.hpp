/* Author: Zachary Kingston */

#ifndef PDDLBOAT_SOLVER_FDPLANNER_
#define PDDLBOAT_SOLVER_FDPLANNER_

#include <pddlboat/utility.hpp>
#include <pddlboat/solver/planner.hpp>
#include <optional>

namespace pddlboat
{
    /** \brief A planner that uses the fast downward planning system, http://www.fast-downward.org/
     * Calls fast downward using a few prebaked search methods. Calls the fast downward executable
     * from the fast downward submodule.
     */
    class FastDownwardPlanner : public Planner
    {
    public:
        /** \brief Predefined search routines for fast downward planning.
         */
        enum Search
        {
            ASTAR,       ///< A*, does not support :derived-predicates
            LAZYGREEDY,  ///< Lazy greedy best-first search with preferred operators and queue alternation
            FDAT,        ///< Fast Downward Autotune 2
            LAMA,        ///< LAMA 2011
            LAMA_FIRST        ///< LAMA that returns the first solution
        };

        /** \brief Options for planner.
         */
        struct Options
        {
            Search search{Search::ASTAR};  ///< Search method to use.
            bool no_simplify_sas{true};    ///< Simplify SAS output in translation.

            Options(){};
        };

        /** \brief Constructor.
         *  \param[in] problem Problem to solve.
         *  \param[in] search Search method to use.
         */
        FastDownwardPlanner(const ProblemPtr &problem, const Options &options = Options());

        /** \brief Destructor. Cleans up generated files.
         */
        ~FastDownwardPlanner();

        /** \brief Returns the supported domain requirements of the FD planner's configuration.
         *  \return The supported requirements.
         */
        Requirements::Keyword getSupportedRequirements() const override;

        /** \brief Update domain or problem PDDL files that the fast downward executable reads. Call this
         * method whenever the problem or domain is updated.
         *  \param[in] domain Update the domain file.
         *  \param[in] problem Update the problem file.
         */
        void update(bool domain = true, bool problem = true);

        /** \brief Solve the planning problem.
         *  \param[out] plan Output plan.
         *  \return True on success, false on failure.
         */
        bool solve(Plan &plan) override;

        /** \brief Solve the planning problem.
         *  \param[out] plan Found plan.
         *  \return True on success, false on failure.
         */
        bool solve(Plan &plan, unsigned int timeout) override;

    protected:
        /** \brief Retrieve or initialize the command for calling fast downward.
         * \return The command to use
         */
        const std::string &getSolverCommand();

        /** \brief Return the correct path to the solver executable
         * \return The path to the executable
         */
        virtual std::string getSolver();

        /** \brief Retrieve or initialize the command for calling the translator to fast downward.
         * \return The command to use
         */
        const std::string &getTranslatorCommand();

        /** \brief Generate the command for calling fast downward.
         *  \return The command to use.
         */
        virtual std::string generateSolverCommand() const;

        /** \brief Generate the command for calling the translator to fast downward.
         *  \return The command to use.
         */
        std::string generateTranslatorCommand() const;

        /** \brief Run the preprocessor command, if any
         * \return True if the preprocessor succeeded, false otherwise
         */
        virtual bool preprocess() const;

        /** \brief Get the directory where the binary resides
         *  \return Path to the binary directory
         */
        virtual const std::string &getDirectory() const;

        const std::string temporary{"/tmp"};  ///< Scratch directory to generate intermediate files.
        // const std::string temporary{"private/tmp"};

        const std::string domain_file_template{"pddlboat_domain_%1%.pddl"};    ///< Template domain name.
        const std::string problem_file_template{"pddlboat_problem_%1%.pddl"};  ///< Template problem name.
        const std::string sas_file_template{"pddlboat_sas_%1%"};     ///< Template intermediate name.
        const std::string output_file_template{"pddlboat_out_%1%"};  ///< Template output name.

        const std::string uuid;             ///< Unique ID for this solver.
        const std::string domain_file;      ///< Domain file for this solver.
        const std::string problem_file;     ///< Problem file for this solver.
        const std::string sas_file;         ///< Intermediate file used by fast downward.
        const std::string output_filename;  ///< Output filename generated by fast downward.
        const std::string output_file;      ///< Output file (directory and filename)

        std::optional<std::string> solver{std::nullopt};              ///< Solver executable.
        std::optional<std::string> solver_command{std::nullopt};      ///< Command to use for solving.
        std::optional<std::string> translator{std::nullopt};          ///< Translator executable.
        std::optional<std::string> translator_command{std::nullopt};  ///< Command to use for translating.
        std::optional<double> translator_time{std::nullopt};          ///< Time taken for last translation.

    private:
        const Options options;                  ///< Planner options.
        const static std::string fd_directory;  ///< Directory where FD executable lives.
    };

}  // namespace pddlboat

#endif