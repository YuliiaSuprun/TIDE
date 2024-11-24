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
// ./run.sh /Users/yuliiasuprun/Desktop/Classes/AlgoRobotics/Research/Code/Plan4Past-data/deterministic/PPLTL/TB15/blocksworld /Users/yuliiasuprun/Desktop/Classes/AlgoRobotics/Research/Code/Plan4Past-data/deterministic/PPLTL/TB15/blocksworld/blocksworld_teg.json 1 --planner fd --search lama

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


int main(int argc, char** argv) {
    if (argc < 3) {
        cerr << "Usage: " << argv[0] << " <Directory Path> <Number of Runs> [--method <'exp', 'poly', 'plan4past'>] [--search <'lama-full', 'lama-first'>] [--goal <Goal JSON File>] [--timeout <in ms>]" << endl;
        exit(EXIT_FAILURE);
    }

    string directoryPath = argv[1];
    int numRuns = stoi(argv[2]);
    string domainFilePath = directoryPath + "/domain.pddl";
    
    string method;
    string search;
    string goalJsonFilePath;
    string goal_expression;
    size_t timeout = 0; // No timeout by default

    for (int i = 3; i < argc; ++i) {
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
        cerr << "ERROR: No method provided. Use --method <method_name>. Options: exp, poly, plan4past" << endl;
        exit(EXIT_FAILURE);
    }

    if (search.empty()) {
        cerr << "ERROR: No search type provided. Use --search <search_type>. Options: lama-first, lama-full" << endl;
        exit(EXIT_FAILURE);
    }

    if (method == "plan4past" && goalJsonFilePath.empty()) {
        cerr << "ERROR: No goal JSON file provided for the plan4past method. Use --goal <Goal JSON File>" << endl;
        exit(EXIT_FAILURE);
    }

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

    for (const auto& entry : filesystem::directory_iterator(directoryPath)) {
        if (!entry.is_regular_file()) {
            // Skip it.
            continue;
        }
        string problemFilePath = entry.path().string();
        if (problemFilePath.find("domain.pddl") != string::npos) {
            // This is the domian file. Skip it.
            continue;
        }
        if (problemFilePath.find(".json") != string::npos) {
            // This is the json file for PPLTL goals. Skip it.
            continue;
        }
        if (problemFilePath.find(".map") != string::npos) {
            // Weird map file. Skip it.
            continue;
        }
        // if (problemFilePath.find("a0") != string::npos) {
        //     // Skip
        //     continue;
        // }


        cout << "Solving " << problemFilePath << "..." << endl;

        // Extract a problem name.
        string problem_name = PDDLProblem::extract_problem_name(problemFilePath);
        string domain_name = PDDLProblem::extract_domain_name(problemFilePath);
        if (method == "plan4past") {
            // Load the goal expression from the JSON file
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
        size_t totalPlanLength = 0;  // Includes all actions
        size_t syncActionsCount = 0; // Count of synchronization actions
        size_t concisePlanLength = 0; // For Poly

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

        // Create the problem subdirectory if it doesn't exist
        dir_name = dir_name + "/" + problem_name;
        filesystem::create_directory(dir_name);

        // Create transformed PDDL files
        string outputDomainPath = dir_name + "/output_domain.pddl";
        string outputProblemPath = dir_name + "/output_problem.pddl";

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
        // cout << "translateCmd: " << translateCmd << endl;

        // Construct the Fast Downward command
        string fastDownwardCmd = "/home/pack-a-punch/Documents/Programming/yuliia/ResearchCode/Task-Planning-with-TEGs/docker_dir/pddlboat/submodules/downward/fast-downward.py --alias " + alias_name + " " + outputDomainPath + " " + outputProblemPath + " > /dev/null 2>&1";

        if (timeout != 0) {
            fastDownwardCmd = "timeout " + to_string(timeout) + " " + fastDownwardCmd;
        }
        // cout << "fastDownwardCmd: " << fastDownwardCmd << endl;

        for (int run = 0; run < numRuns; ++run) {
            cout << "Run #" << run + 1 << " for " << problemFilePath << endl;
            // Step 1: Translate into the classical problem with P4P
            auto translate_start = chrono::high_resolution_clock::now();
            pddlboat::io::runCommand(translateCmd);
            // system(translateCmd.c_str());  // Run the command
            auto translate_end = chrono::high_resolution_clock::now();
            chrono::duration<double> translate_elapsed = translate_end - translate_start;

            // Output the time taken to translate into a classical problem
            cout << "Translation time: " << translate_elapsed.count() << " seconds" << endl;

            // Step 2: Generate a solution running a classical planner (FD - LAMA)
            string planFilePath = dir_name + "/" + problem_name + "_plan_" + to_string(run + 1);

            // Run the Fast Downward command
            auto fd_start = chrono::high_resolution_clock::now();
            pddlboat::io::runCommand(fastDownwardCmd);
            // system(fastDownwardCmd.c_str());  // Execute the Fast Downward command

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
                } else {
                    string line;
                    // Regex to match the line with the cost information
                    regex costRegex("; cost = ([0-9]+)");
                    // Regex to identify synchronization actions 
                    // (lines starting with "(o_"
                    regex syncActionRegex("^\\(o_.*\\)");
                    // Process each line from the plan file
                    while (getline(sasPlanFile, line)) {
                        // Copy the contents from a sas plan file to planFilePath
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

                if (method == "poly") {
                    // Calculate the normal plan length by excluding sync actions
                    concisePlanLength = totalPlanLength - syncActionsCount;
                }

                // Clean up the helper files generated by the FD planner.
                if (std::remove(plan_file_name.c_str()) != 0)
                {
                    cerr << "Failed to remove a plan file: " << plan_file_name << endl;
                }
            }
            totalTranslateTime += translate_elapsed.count();
            totalSearchTime += fd_elapsed.count();
        }
        double averageTranslateTime = totalTranslateTime / numRuns;
        double averageSearchTime = totalSearchTime / numRuns;
        double averageTotalTime = (totalTranslateTime + totalSearchTime) / numRuns;
        double averagePlanLength = static_cast<double>(totalPlanLength) / numRuns;
        double averageConcisePlanLength = static_cast<double>(concisePlanLength) / numRuns;

        // Print statistics to stdout (console)
        printStats(std::cout, numRuns, averageTranslateTime, averageSearchTime, averageTotalTime, averagePlanLength, averageConcisePlanLength);

        // Create the stats file
        string statsFilePath = dir_name + "/stats.txt";
        ofstream statsFile(statsFilePath);

        // Check if the file is open before writing
        if (!statsFile.is_open()) {
            cerr << "Failed to open stats file: " << statsFilePath << endl;
            return EXIT_FAILURE;
        }

        // Print statistics to the file
        printStats(statsFile, numRuns, averageTranslateTime, averageSearchTime, averageTotalTime, averagePlanLength, averageConcisePlanLength);

        // Close the file
        statsFile.close();
    }

    return 0;
}