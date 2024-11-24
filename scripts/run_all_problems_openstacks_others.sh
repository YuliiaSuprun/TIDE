#!/bin/bash
# Add the directory containing libpddlboat-cpp.so to LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/Documents/Programming/yuliia/ResearchCode/Task-Planning-with-TEGs/docker_dir/pddlboat/build/release

# Add Anaconda environment's lib directory to LD_LIBRARY_PATH (correcting Miniconda to Anaconda)
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/anaconda3/envs/spotenv/lib

# Set the base directory path for your problems and domain files
BASE_DIR="$HOME/Documents/Programming/yuliia/ResearchCode/Task-Planning-with-TEGs/docker_dir/data/deterministic/LTLf/BF23/openstacks"

# Iterate from p01 to p30
for i in $(seq -f "%02g" 1 5); do  # '-f' ensures two-digit padding
    DOMAIN_FILE="$BASE_DIR/domain_p${i}.pddl"
    PROBLEM_FILE="$BASE_DIR/p${i}.pddl"
    echo "Solving problem: $PROBLEM_FILE with domain: $DOMAIN_FILE"

    # Call the single problem solver
    ./bin/main_single_others "$DOMAIN_FILE" "$PROBLEM_FILE" 1 --method "$@" --timeout 3600 --goal "$BASE_DIR/openstacks_teg.json" --search lama-first

    # Check the exit code of the previous command
    if [ $? -ne 0 ]; then
        echo "Problem $PROBLEM_FILE timed out or exited with an error."
        # Continue to the next problem even if the previous one failed
        continue
    fi

    echo "Successfully solved problem: $PROBLEM_FILE"
done

echo "All problems processed."