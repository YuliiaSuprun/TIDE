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

// Function to add constants to the domain file and modify the problem file
void addConstantsAndModifyObjects(const std::string &domainFilePath, const std::string &problemFilePath) {
    // Modify the domain file
    std::ifstream domainFile(domainFilePath);
    if (!domainFile.is_open()) {
        throw std::runtime_error("Failed to open domain file: " + domainFilePath);
    }

    std::string domainContent;
    std::string line;
    bool constantsAdded = false;

    while (std::getline(domainFile, line)) {
        // Add constants after the closing parenthesis of the `(:types)` section
        domainContent += line + "\n";
        if (!constantsAdded && line.find("(:types") != std::string::npos) {
            while (std::getline(domainFile, line)) {
                domainContent += line + "\n";
                if (line.find(')') != std::string::npos) {
                    domainContent += "    (:constants\n"
                                     "      b1 b2 b3 b4 b5 b6 - block\n"
                                     "    )\n";
                    constantsAdded = true;
                    break;
                }
            }
        }
    }
    domainFile.close();

    if (!constantsAdded) {
        throw std::runtime_error("Failed to locate the appropriate section in the domain file to add constants.");
    }

    // Write the updated content back to the domain file
    std::ofstream updatedDomainFile(domainFilePath);
    if (!updatedDomainFile.is_open()) {
        throw std::runtime_error("Failed to open domain file for writing: " + domainFilePath);
    }
    updatedDomainFile << domainContent;
    updatedDomainFile.close();

    // Open the problem file
    std::ifstream problemFile(problemFilePath);
    if (!problemFile.is_open()) {
        throw std::runtime_error("Failed to open problem file: " + problemFilePath);
    }

    std::string problemContent;
    bool objectsReplaced = false;

    while (std::getline(problemFile, line)) {
        if (line.find("(:objects") != std::string::npos && !objectsReplaced) {
            // Replace the objects line with "(:objects noobjects)"
            problemContent += "    (:objects noobjects)\n";
            objectsReplaced = true;
            // // Skip the subsequent lines for the objects section
            // while (std::getline(problemFile, line) && line.find(')') == std::string::npos) {
            //     continue; // Skip until the closing parenthesis
            // }
        } else {
            // Add the current line to the problem content
            problemContent += line + "\n";
        }
    }
    problemFile.close();

    if (!objectsReplaced) {
        throw std::runtime_error("Failed to locate the `(:objects)` section in the problem file.");
    }

    // Write the updated content back to the problem file
    std::ofstream updatedProblemFile(problemFilePath);
    if (!updatedProblemFile.is_open()) {
        throw std::runtime_error("Failed to open problem file for writing: " + problemFilePath);
    }
    updatedProblemFile << problemContent;
    updatedProblemFile.close();
}


int countRealActions(const std::string &filePath) {
    std::ifstream inputFile(filePath);
    if (!inputFile.is_open()) {
        throw std::runtime_error("Failed to open file: " + filePath);
    }

    std::string line;
    bool startProcessing = false;
    int realActionCount = 0;

    // Regex to match lines starting with "(o_"
    std::regex syncActionRegex("^\\(o_.*\\)");

    while (std::getline(inputFile, line)) {
        // Skip lines until we encounter "(o_copy)"
        if (!startProcessing) {
            if (line.find("(o_copy)") != std::string::npos) {
                startProcessing = true;
            }
            continue;
        }

        // Skip empty lines
        if (line.empty()) {
            continue;
        }

        // Check if the line doesn't start with "(o_" (i.e., is a real action)
        if (!std::regex_match(line, syncActionRegex)) {
            ++realActionCount;
        }
    }

    inputFile.close();
    return realActionCount;
}

void removeQuotes(const std::string &filePath) {
    // Open the input file for reading
    std::ifstream inputFile(filePath);
    if (!inputFile.is_open()) {
        throw std::runtime_error("Failed to open file: " + filePath);
    }

    std::string fileContent;
    std::string line;

    // Read the file line by line
    while (std::getline(inputFile, line)) {
        // Remove all single and double quotes
        line.erase(std::remove(line.begin(), line.end(), '\''), line.end());
        line.erase(std::remove(line.begin(), line.end(), '\"'), line.end());
        fileContent += line + '\n';
    }
    inputFile.close();

    // Open the output file for writing
    std::ofstream outputFile(filePath);
    if (!outputFile.is_open()) {
        throw std::runtime_error("Failed to open file for writing: " + filePath);
    }

    // Write the modified content back to the file
    outputFile << fileContent;
    outputFile.close();

    // Debug message (optional)
    // std::cout << "Removed all quotes from file: " << filePath << std::endl;
}


// Example command to run plan4past:
// plan4past -d examples/pddl/domain.pddl -p examples/pddl/p-0.pddl -g "ontable_c & O(on_b_a)" -od output_domain.pddl -op output_problem.pddl
void addRequirementsLine(const std::string &filePath) {
    // Read the content of the file
    std::ifstream inputFile(filePath);
    if (!inputFile.is_open()) {
        throw std::runtime_error("Failed to open file: " + filePath);
    }

    std::string fileContent;
    std::string line;
    bool requirementsAdded = false;

    while (std::getline(inputFile, line)) {
        // Check if the requirements line already exists
        if (line.find("(:requirements") != std::string::npos) {
            requirementsAdded = true; // If found, no need to add it again
        }
        fileContent += line + '\n';
    }
    inputFile.close();

    // If the requirements line is missing, add it right after the domain definition
    if (!requirementsAdded) {
        size_t definePos = fileContent.find("(define (domain");
        if (definePos == std::string::npos) {
            throw std::runtime_error("Invalid domain file: missing '(define (domain ...)'");
        }

        // Find the end of the domain name line
        size_t endOfDomainLine = fileContent.find('\n', definePos);
        if (endOfDomainLine == std::string::npos) {
            throw std::runtime_error("Invalid domain file: missing newline after domain definition.");
        }

        // Add the requirements line after the domain name
        std::string requirementsLine = "  (:requirements :strips :typing :derived-predicates)\n";
        fileContent.insert(endOfDomainLine + 1, requirementsLine);
    }

    // Write the updated content back to the file
    std::ofstream outputFile(filePath);
    if (!outputFile.is_open()) {
        throw std::runtime_error("Failed to open file for writing: " + filePath);
    }

    outputFile << fileContent;
    outputFile.close();

    // std::cout << "Added requirements line to domain file: " << filePath << std::endl;
}

void replaceNoTypeWithObject(const std::string &filePath) {
    // Read the content of the file
    std::ifstream inputFile(filePath);
    if (!inputFile.is_open()) {
        throw std::runtime_error("Failed to open file: " + filePath);
    }

    std::string fileContent;
    std::string line;

    while (std::getline(inputFile, line)) {
        // Replace "NO_TYPE" with "object" in each line
        size_t pos;
        while ((pos = line.find("NO_TYPE")) != std::string::npos) {
            line.replace(pos, 7, "object");
        }
        fileContent += line + '\n';
    }
    inputFile.close();

    // Write the updated content back to the file
    std::ofstream outputFile(filePath);
    if (!outputFile.is_open()) {
        throw std::runtime_error("Failed to open file for writing: " + filePath);
    }

    outputFile << fileContent;
    outputFile.close();

    // std::cout << "Replaced all occurrences of \"NO_TYPE\" with \"object\" in file: " << filePath << std::endl;
}
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
    if (argc < 3) {
        cerr << "Usage: " << argv[0] << " <Directory Path> <Number of Runs> [--method <'exp', 'poly', 'plan4past', 'fond4ltlf'>] [--planner <'astar', 'fd'>] [--search <'lama-full', 'lama-first'>] [--goal <Goal JSON File>] [--timeout <in ms>]" << endl;
        exit(EXIT_FAILURE);
    }

    string directoryPath = argv[1];

    // Ensure directoryPath is absolute
    filesystem::path directoryPathObj(directoryPath);
    directoryPath = filesystem::absolute(directoryPathObj).string();

    int numRuns = stoi(argv[2]);
    string domainFilePath = directoryPath + "/domain.pddl";
    string domain_name = PDDLProblem::extract_domain_name(domainFilePath);
    
    string method;
    string planner_type;
    string search;
    string goalJsonFilePath;
    string goal_expression;
    size_t timeout = 0; // No timeout by default

    string plan_file_name;
    string alias_name;

    for (int i = 3; i < argc; ++i) {
        string arg = argv[i];
        if (arg == "--method" && i + 1 < argc) {
            method = argv[++i]; // Move to the next argument
        } else if (arg == "--planner" && i + 1 < argc) {
            planner_type = argv[++i]; // Move to the next argument
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

    // Validate planner type
    if (planner_type.empty()) {
        cerr << "No planner type provided. Use --planner <planner_type>. Options: fd, astar" << endl;
        exit(EXIT_FAILURE);
    } else {
        cout << "Using the planner: " << planner_type << endl;
    }

    if (planner_type == "fd" && search.empty()) {
        cerr << "No search type provided for the FD planner. Use --search <search_type>. Options: lazygreedy, fdat, lama-first, lama-full" << endl;
        exit(EXIT_FAILURE);
    } else if (planner_type == "fd") {
        cout << "Using the search: " << search << endl;
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
    }

    if ((method == "plan4past" || method == "fond4ltlf") && goalJsonFilePath.empty()) {
        cerr << "ERROR: No goal JSON file provided for the " << method << " method. Use --goal <Goal JSON File>" << endl;
        exit(EXIT_FAILURE);
    }


    string currentPath = filesystem::current_path().string();

    string common_dir_name = currentPath + "/solutions";
    // Create the solutions directory if it doesn't exist
    filesystem::create_directory(common_dir_name);

    common_dir_name = common_dir_name + "/" + method;
    // Create the solutions directory for specific if it doesn't exist
    filesystem::create_directory(common_dir_name);

    // Create the planner subdirectory if it doesn't exist
    common_dir_name = common_dir_name + "/" + planner_type;
    filesystem::create_directory(common_dir_name);

    // Create the domain subdirectory if it doesn't exist
    common_dir_name = common_dir_name + "/" + search;
    filesystem::create_directory(common_dir_name);

    // Create the domain subdirectory if it doesn't exist
    common_dir_name = common_dir_name + "/" + domain_name;
    filesystem::create_directory(common_dir_name);

    // Define the general statistics file path
    string generalStatsFilePath = common_dir_name + "/overall_stats.txt";
    // Open the general statistics file in append mode
    ofstream generalStatsFile(generalStatsFilePath, ios::app);
    if (!generalStatsFile.is_open()) {
        cerr << "Failed to open general stats file: " << generalStatsFilePath << endl;
        return EXIT_FAILURE;
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


        cout << "Solving " << problemFilePath << "..." << endl;

        // Extract a problem name.
        string problem_name = PDDLProblem::extract_problem_name(problemFilePath);

        if (method == "plan4past" || method == "fond4ltlf") {
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
        size_t concisePlanLength = 0; // For poly and fond4ltlf

        // Create the problem subdirectory if it doesn't exist
        string dir_name = common_dir_name + "/" + problem_name;
        filesystem::create_directory(dir_name);

        // Create transformed PDDL files
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
            // Step 1: Translate into the classical problem with P4P
            auto translate_start = chrono::high_resolution_clock::now();
            pddlboat::io::runCommand(translateCmd);
            // system(translateCmd.c_str());  // Run the command
            auto translate_end = chrono::high_resolution_clock::now();
            chrono::duration<double> translate_elapsed = translate_end - translate_start;

            // Output the time taken to translate into a classical problem
            cout << "Translation time: " << translate_elapsed.count() << " seconds" << endl;

            // Step 2: Generate a solution running a classical planner (FD - LAMA) or A*
            string planFilePath = dir_name + "/" + problem_name + "_plan_" + to_string(run + 1);

            chrono::duration<double> search_elapsed;

            // Run the Fast Downward command
            if (planner_type == "fd") {
                auto fd_start = chrono::high_resolution_clock::now();
                pddlboat::io::runCommand(fastDownwardCmd);
                auto fd_end = chrono::high_resolution_clock::now();
                search_elapsed = fd_end - fd_start;
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

                    if (method == "poly" || method == "fond4ltlf") {
                        // Calculate the normal plan length by excluding sync actions
                        concisePlanLength = totalPlanLength - syncActionsCount;
                    }

                    // Clean up the helper files generated by the FD planner.
                    removeFilesWithPrefix(".", "sas_plan");
                }
            } else {
                // Use A* planner otherwise.
                cout << "Initializing A* planner for problem: " << problemFilePath << endl;
                // Use A* planner otherwise.
                // 1. Create and parse the PDDL problem
                try {
                    replaceNoTypeWithObject(outputDomainPath);
                    removeQuotes(outputDomainPath);
                    removeQuotes(outputProblemPath);
                    addRequirementsLine(outputDomainPath);
                    // addConstantsAndModifyObjects(outputDomainPath, outputProblemPath);
                } catch (const std::exception &e) {
                    std::cerr << "Error: " << e.what() << std::endl;
                }
                // Parse the domain file into a pddlboat::DomainPtr
                auto domainPtr = PDDLDomain::parseDomain(outputDomainPath);

                cout << "Domain parsed" << endl;

                // Parse the problem file into a pddlboat::ProblemPtr using the domain
                auto problemPtr = PDDLProblem::parseProblem(outputProblemPath, domainPtr);
                cout << "Problem parsed" << endl;


                // 2. Initialize the A* planner
                auto task_planner = std::make_shared<pddlboat::AStarPlanner>(problemPtr);
                /// 3. Create a plan object
                auto plan = std::make_shared<pddlboat::Plan>(problemPtr);

                cout << "About to solve" << endl;
                auto astar_start = chrono::high_resolution_clock::now();
                // 4. Solve the problem
                if (!task_planner->solve(*plan, timeout))
                {
                    cerr << "ERROR: No solution was found." << endl;
                    continue;
                }
                auto astar_end = chrono::high_resolution_clock::now();
                search_elapsed = astar_end - astar_start;
                cout << "Solved!" << endl;
                // 5. Retrieve the plan steps
                auto plan_steps = plan->getSteps();
                if (plan_steps.empty()) {
                    cerr << "ERROR: the plan is empty! Search failed." << endl;
                    continue;
                }

                // 6. Write the plan to the specified file
                ofstream planFile(planFilePath);
                if (!planFile.is_open()) {
                    cerr << "Failed to open output plan file: " << planFilePath << endl;
                    exit(EXIT_FAILURE);
                } 
                cout << "Writing the plan to: " << planFilePath << endl;
                planFile << "Plan for problem: " << problemFilePath << "\n\n";
                for (const auto& step : plan_steps) {
                    step.toString(planFile) << endl; // Write each step 
                }
                planFile.close();
                int planLength = countRealActions(planFilePath);
                std::cout << "Number of real actions: " << planLength << std::endl;
                totalPlanLength += planLength; 
            }

            // Output the time taken
            cout << "Search time: " << search_elapsed.count() << " seconds" << endl;
            totalTranslateTime += translate_elapsed.count();
            totalSearchTime += search_elapsed.count();
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
            return EXIT_FAILURE;
        }

        // Print statistics to the file
        printStats(statsFile, numRuns, averageTranslateTime, averageSearchTime, averageTotalTime, averagePlanLength, averageConcisePlanLength);

        // Close the file
        statsFile.close();
    }

    // Close the general stats file
    generalStatsFile.close();

    // After running experiments, clean up all temporary files
    try {
        if (method == "exp") {
            filesystem::remove_all("competitors/pddlTEG2pddl/tmp");
        } else if (method == "poly") {
            filesystem::remove_all("competitors/prologex/tmp");
        }
    } catch (const std::exception& e) {
        std::cerr << "Error cleaning up temporary files: " << e.what() << std::endl;
    }

    return 0;
}