#include <iostream>
#include <fstream>
#include <filesystem>
#include <vector>
#include <set>
#include <map>
#include <string>
#include <utility>
#include <chrono>
#include <cstdlib>
#include <nlohmann/json.hpp>
#include <regex>

#include "PDDLDomain.h"
#include "PDDLProblem.h"
#include <pddlboat/utility.hpp>
#include <pddlboat/parser/parser.hpp>
#include <pddlboat/parser/translator.hpp>
#include <pddlboat/parser/ast.hpp>
#include <pddlboat/solver/expressions.hpp>
#include <pddlboat/solver/domain.hpp>
#include <pddlboat/solver/planner.hpp>
#include <pddlboat/solver/fdplanner.hpp>
#include <pddlboat/solver/z3planner.hpp>
#include <pddlboat/solver/astarplanner.hpp>

using namespace std;

// Example of the command

// Example command to run plan4past:
// plan4past -d examples/pddl/domain.pddl -p examples/pddl/p-0.pddl -g "ontable_c & O(on_b_a)" -od output_domain.pddl -op output_problem.pddl

// Function to print stats to any output stream (either console or file)
void printStats(std::ostream& os, int numRuns, double averageTranslateTime, double averageSearchTime, double averageTotalTime, double averagePlanLength, double averageConcisePlanLength) {
    os << "For " << numRuns << " runs:" << std::endl;
    os << "Average translate time: " << averageTranslateTime << " seconds" << std::endl;
    os << "Average solve time: " << averageSearchTime << " seconds" << std::endl;
    os << "Average total time: " << averageTotalTime << " seconds" << std::endl;
    os << "Average plan length: " << averagePlanLength << std::endl;
    if (averageConcisePlanLength != 0) {
        os << "Average concise plan length: " << averageConcisePlanLength << std::endl;
    }
}

// Helper function to remove all files in a directory
void cleanUpTempFiles(const std::string& tempDir) {
    for (const auto& entry : filesystem::directory_iterator(tempDir)) {
        if (entry.is_regular_file()) {
            try {
                filesystem::remove(entry.path());
            } catch (const std::exception& e) {
                cerr << "Failed to remove file " << entry.path() << ": " << e.what() << endl;
            }
        }
    }
}

// Helper function to remove all files starting with a specific prefix in a given directory
void removeFilesWithPrefix(const std::string& directory, const std::string& prefix) {
    try {
        for (const auto& entry : std::filesystem::directory_iterator(directory)) {
            if (entry.is_regular_file() && entry.path().filename().string().find(prefix) == 0) {
                std::filesystem::remove(entry.path());
            }
        }
    } catch (const std::exception& e) {
        std::cerr << "Error removing files with prefix \"" << prefix << "\": " << e.what() << std::endl;
    }
}


int main(int argc, char** argv) {
    if (argc < 4) {
        cerr << "Usage: " << argv[0] << " <PDDL Domain File> <PDDL Problem File> <Number of Runs> [--method <'exp', 'poly', 'plan4past', 'fond4ltlf'>] [--search <'lama-full', 'lama-first'>] [--goal <Goal JSON File>] [--timeout <in ms>]" << endl;
        exit(EXIT_FAILURE);
    }

    string domainFilePath = argv[1];
    string problemFilePath = argv[2];

    // Ensure domainFilePath and problemFilePath are absolute
    filesystem::path domainPathObj(domainFilePath);
    filesystem::path problemPathObj(problemFilePath);
    domainFilePath = filesystem::absolute(domainPathObj).string();
    problemFilePath = filesystem::absolute(problemPathObj).string();
    
    // Extract a problem name.
    string problem_name = PDDLProblem::extract_problem_name(problemFilePath);
    string domain_name = PDDLProblem::extract_domain_name(problemFilePath);
    // Extract the parent directory
    filesystem::path pathObj(problemFilePath);
    string directoryPath = pathObj.parent_path().string();

    int numRuns = stoi(argv[3]);

    string method;
    string search;
    string goalJsonFilePath;
    string goal_expression;
    size_t timeout = 0; // No timeout by default

    for (int i = 4; i < argc; ++i) {
        string arg = argv[i];
        if (arg == "--method" && i + 1 < argc) {
            method = argv[++i]; // Move to the next argument
        } else if (arg == "--search" && i + 1 < argc) {
            search = argv[++i]; // Move to the next argument
        } else if (arg == "--goal" && i + 1 < argc) {
            goalJsonFilePath = argv[++i]; // Move to the next argument
        } else if (arg == "--timeout" && i + 1 < argc) {
            timeout = stoi(argv[++i]); // Move to the next argument
        } else {
            cerr << "Unknown argument: " << arg << endl;
            exit(EXIT_FAILURE);
        }
    }

    if (method.empty()) {
        cerr << "ERROR: No method provided. Use --method <method_name>. Options: exp, poly, plan4past, fond4ltlf" << endl;
        exit(EXIT_FAILURE);
    }

    if (search.empty()) {
        cerr << "ERROR: No search type provided. Use --search <search_type>. Options: lama-first, lama-full" << endl;
        exit(EXIT_FAILURE);
    }

    if (method == "plan4past" || method == "fond4ltlf") {
        if (goalJsonFilePath.empty()) {
            cerr << "ERROR: No goal JSON file provided for the " << method << " method. Use --goal <Goal JSON File>" << endl;
            exit(EXIT_FAILURE);
        }

        // Attempt to load goal expression from a goal JSON file.
        try {
            ifstream jsonFile(goalJsonFilePath);
            if (!jsonFile.is_open()) {
                cerr << "Error opening JSON file: " << goalJsonFilePath << endl;
                exit(EXIT_FAILURE);
            }

            // Parse the JSON file
            nlohmann::json goalData;
            jsonFile >> goalData;

            // Find the goal expression for the extracted problem name
            if (goalData.contains(problem_name)) {
                goal_expression = goalData[problem_name].get<string>();
                cout << "Goal expression for " << problem_name << ": " << goal_expression << endl;
            } else {
                cerr << "Problem name not found in the JSON file: " << problem_name << endl;
                exit(EXIT_FAILURE);
            }

        } catch (const std::exception &e) {
            std::cerr << "Error parsing JSON file: " << e.what() << std::endl;
            exit(EXIT_FAILURE);
        }
    }

    // Variables to store total elapsed time for averaging
    double totalTranslateTime = 0;
    double totalSearchTime = 0;
    size_t totalPlanLength = 0;
    size_t syncActionsCount = 0; // Count of synchronization actions
    size_t concisePlanLength = 0; // For Poly and fond4ltlf

    string currentPath = filesystem::current_path().string();

    string dir_name = currentPath + "/solutions";
    // Create the solutions directory if it doesn't exist
    filesystem::create_directory(dir_name);

    dir_name = dir_name + "/" + method;
    // Create the solutions directory for specific if it doesn't exist
    filesystem::create_directory(dir_name);

    // Create the domain subdirectory if it doesn't exist
    dir_name = dir_name + "/" + search;
    filesystem::create_directory(dir_name);

    // Create the domain subdirectory if it doesn't exist
    dir_name = dir_name + "/" + domain_name;
    filesystem::create_directory(dir_name);

    // Define the general statistics file path
    string generalStatsFilePath = dir_name + "/overall_stats.txt";
    // Open the general statistics file in append mode
    ofstream generalStatsFile(generalStatsFilePath, ios::app);
    if (!generalStatsFile.is_open()) {
        cerr << "Failed to open general stats file: " << generalStatsFilePath << endl;
        return EXIT_FAILURE;
    }

    // Create the problem subdirectory if it doesn't exist
    dir_name = dir_name + "/" + problem_name;
    filesystem::create_directory(dir_name);

    // Create transformed PDDL files
    string outputDomainPath = dir_name + "/output_domain.pddl";
    string outputProblemPath = dir_name + "/output_problem.pddl";

    string plan_file_name;
    string alias_name;
    if (search == "lama-full") {
        plan_file_name = "sas_plan.1";
        alias_name = "seq-sat-lama-2011";
    } else if (search == "lama-first") {
        plan_file_name = "sas_plan";
        alias_name = "lama-first";
    } else {
        cerr << "ERROR: Unknown search: " << search << ". Valid options: lama-first, lama-full" << endl;
        exit(EXIT_FAILURE);
    }

    string mapFilePath = directoryPath + "/" + problem_name + ".map";
    string mapFileArgString; // Empty by default
    if (filesystem::exists(mapFilePath)) {
        // If the map file exists, include it in the command
        mapFileArgString = " -m " + mapFilePath;
    } 
    string translateCmd;
    if (method == "plan4past") {
        // Construct `plan4past` command
        translateCmd = "plan4past -d " + domainFilePath + " -p " + problemFilePath + " -g \"" + goal_expression + "\"" + mapFileArgString + " -od " + outputDomainPath + " -op " + outputProblemPath + " > /dev/null 2>&1";
    } else if (method == "fond4ltlf") {
        translateCmd = "fond4ltlf -d " + domainFilePath + " -p " + problemFilePath + " -g \"" + goal_expression + "\" -outd " + outputDomainPath + " -outp " + outputProblemPath + " > /dev/null 2>&1";
    } else if (method == "exp") {
        // Run a script from ltl_compilations/pddlTEG2pddl directory
        translateCmd = "cd competitors/pddlTEG2pddl; ./convert.sh " + domainFilePath + " " + problemFilePath + " " + outputDomainPath + " " + outputProblemPath + " dp > /dev/null 2>&1";
    } else if (method == "poly") {
        // Run a script from ltl_compilations/pddlTEG2pddl directory
        translateCmd = "cd competitors/prologex; ./launch_compilation.sh " + domainFilePath + " " + problemFilePath + " " + outputDomainPath + " " + outputProblemPath + " 2 > /dev/null 2>&1";
    } else {
        cerr << "ERROR: Unknown method: " << method << endl;
        exit(EXIT_FAILURE);
    }
    cout << "translateCmd: " << translateCmd << endl;

    // Get the base path from the environment variable, or use the default local path (modify it)
    const char* basePath = std::getenv("FAST_DOWNWARD_BASE_PATH");
    std::string basePathStr = basePath ? basePath : "/home/pack-a-punch/Documents/Programming/yuliia/ResearchCode/Task-Planning-with-TEGs/docker_dir/pddlboat/submodules/downward";

    // Construct the Fast Downward command
    std::string fastDownwardCmd = basePathStr + "/fast-downward.py --alias " + alias_name + " " + outputDomainPath + " " + outputProblemPath + " > /dev/null 2>&1";
    if (timeout != 0) {
        fastDownwardCmd = "timeout " + to_string(timeout) + " " + fastDownwardCmd;
    }
    cout << "fastDownwardCmd: " << fastDownwardCmd << endl;

    for (int run = 0; run < numRuns; ++run) {
        cout << "Run #" << run + 1 << " for " << problemFilePath << endl;

        // Step 1: Translate into the classical problem with plan4past
        auto translate_start = chrono::high_resolution_clock::now();
        pddlboat::io::runCommand(translateCmd);  // Run the command
        auto translate_end = chrono::high_resolution_clock::now();
        chrono::duration<double> translate_elapsed = translate_end - translate_start;

        // Output the time taken to translate into a classical problem
        cout << "Translation time: " << translate_elapsed.count() << " seconds" << endl;

        // Step 2: Generate a solution running a classical planner (FD - LAMA)
        string planFilePath = dir_name + "/" + problem_name + "_plan_" + to_string(run + 1);

        // Run the Fast Downward command
        auto fd_start = chrono::high_resolution_clock::now();
        pddlboat::io::runCommand(fastDownwardCmd);  // Execute the Fast Downward command

        // Measure time
        auto fd_end = chrono::high_resolution_clock::now();
        chrono::duration<double> fd_elapsed = fd_end - fd_start;

        // Output the time taken
        cout << "Fast Downward execution time: " << fd_elapsed.count() << " seconds" << endl;

        // Check if the Fast Downward plan was generated
        ifstream sasPlanFile(plan_file_name);
        if (!sasPlanFile.is_open()) {
            cerr << "Failed to generate a plan for run #" << run + 1 << endl;
        } else {
            // Open the destination file for the plan
            ofstream outFile(planFilePath);
            if (!outFile.is_open()) {
                cerr << "Failed to open output plan file: " << planFilePath << endl;
                exit(EXIT_FAILURE);
            } else {
                string line;
                // Regex to match the line with the cost information
                regex costRegex("; cost = ([0-9]+)");
                // Select the appropriate sync action regex based on the method
                regex syncActionRegex;
                if (method == "poly") {
                    // poly sync actions start with "(o_"
                    syncActionRegex = regex("^\\(o_.*\\)"); 
                } else if (method == "fond4ltlf") {
                    // fond4ltlf sync actions start with "(trans-"
                    syncActionRegex = regex("^\\(trans-.*\\)"); 
                } else {
                    // Matches nothing, effectively skips the check
                    syncActionRegex = regex("$a");
                }
                // Process each line from the plan file
                while (getline(sasPlanFile, line)) {
                    // Copy the contents from plan file to planFilePath
                    outFile << line << endl;
                    // Check for synchronization actions
                    if (regex_match(line, syncActionRegex)) {
                        syncActionsCount++;  // Increment sync action counter
                    }
                    // Check for cost information and extract the plan length
                    smatch match;
                    if (regex_search(line, match, costRegex)) {
                        // Extract and convert the plan length
                        size_t planLength = stoi(match[1].str());
                        totalPlanLength += planLength; 
                        cout << "Plan length: " << planLength << endl;
                    }
                }
                outFile.close();
            }
            sasPlanFile.close();

            if (method == "poly" || method == "fond4ltlf") {
                // Calculate the normal plan length by excluding sync actions
                concisePlanLength = totalPlanLength - syncActionsCount;
            }

            // Clean up the helper files generated by the FD planner.
            removeFilesWithPrefix(".", "sas_plan");
        }
        totalTranslateTime += translate_elapsed.count();
        totalSearchTime += fd_elapsed.count();
    }
    double averageTranslateTime = totalTranslateTime / numRuns;
    double averageSearchTime = totalSearchTime / numRuns;
    double averageTotalTime = (totalTranslateTime + totalSearchTime) / numRuns;
    double averagePlanLength = static_cast<double>(totalPlanLength) / numRuns;
    double averageConcisePlanLength = static_cast<double>(concisePlanLength) / numRuns;

    // Append summary statistics to the general stats file
    generalStatsFile << "For " << problem_name << " (" << numRuns << " runs): " << endl;
    generalStatsFile << "Average total time: " << averageTotalTime << " seconds" << endl;
    generalStatsFile << "Average plan length: " << averagePlanLength << endl;
    if (averageConcisePlanLength != 0) {
        generalStatsFile << "Average concise plan length: " << averageConcisePlanLength << endl;
    }
    generalStatsFile << "-----------------------------------------------" << endl;

    // Print statistics to stdout (console)
    printStats(std::cout, numRuns, averageTranslateTime, averageSearchTime, averageTotalTime, averagePlanLength, averageConcisePlanLength);

    // Create the stats file
    string statsFilePath = dir_name + "/stats.txt";
    ofstream statsFile(statsFilePath);

    // Check if the file is open before writing
    if (!statsFile.is_open()) {
        cerr << "Failed to open stats file: " << statsFilePath << endl;
        exit(EXIT_FAILURE);
    }

    // Print statistics to the file
    printStats(statsFile, numRuns, averageTranslateTime, averageSearchTime, averageTotalTime, averagePlanLength, averageConcisePlanLength);

    // Close the file
    statsFile.close();

    // Close the general stats file
    generalStatsFile.close();

    // After running experiments, clean up all temporary files
    if (method == "poly" || method == "exp") {
        std::string tempDirPoly = "competitors/pddlTEG2pddl/tmp";
        std::string tempDirExp = "competitors/prologex/tmp";

        try {
            cleanUpTempFiles(tempDirPoly);
            cleanUpTempFiles(tempDirExp);
        } catch (const std::exception& e) {
            cerr << "Error cleaning up temporary files: " << e.what() << endl;
        }
    }

    return 0;
}