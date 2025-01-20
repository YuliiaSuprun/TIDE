#!/bin/bash
# Add the directory containing libpddlboat-cpp.so to LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/Documents/Programming/yuliia/ResearchCode/Task-Planning-with-TEGs/docker_dir/pddlboat/build/release

# Add Anaconda environment's lib directory to LD_LIBRARY_PATH (correcting Miniconda to Anaconda)
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/anaconda3/envs/spotenv/lib

# Set the base directory path for your problems and domain file
# BASE_DIR="$HOME/Documents/Programming/yuliia/ResearchCode/Task-Planning-with-TEGs/docker_dir/data/deterministic/FOND4LTLf/S24/blocksworld"
BASE_DIR="$HOME/Documents/Programming/yuliia/ResearchCode/Task-Planning-with-TEGs/docker_dir/data/deterministic/FOND4LTLf/S24/blocksworld"
DOMAIN_FILE="$BASE_DIR/domain.pddl"

# Iterate from p10 to p30
for i in {3..25}; do
    PROBLEM_FILE="$BASE_DIR/t${i}.pddl"
    echo "Solving problem: $PROBLEM_FILE"

    # Call the single problem solver
    ./bin/main_single_others "$DOMAIN_FILE" "$PROBLEM_FILE" 1 --method "$@" --search lama-first --goal "$BASE_DIR/blocksworld_teg2.json"

    # Check the exit code of the previous command
    if [ $? -ne 0 ]; then
        echo "Problem $PROBLEM_FILE timed out or exited with an error."
        # Continue to the next problem even if the previous one failed
        continue
    fi

    echo "Successfully solved problem: $PROBLEM_FILE"
done

echo "All problems processed."