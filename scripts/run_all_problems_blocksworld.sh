#!/bin/bash

# Set the base directory path for your problems and domain file
BASE_DIR="/app/data/deterministic/LTLf/S24/blocksworld"
DOMAIN_FILE="$BASE_DIR/domain.pddl"

# Iterate from p10 to p30
for i in {3..30}; do
    PROBLEM_FILE="$BASE_DIR/m${i}.pddl"
    echo "Solving problem: $PROBLEM_FILE"

    # Call the single problem solver
    /app/bin/main_single "$DOMAIN_FILE" "$PROBLEM_FILE" 1 -f -h -c --planner fd --search lama-first

    # Check the exit code of the previous command
    if [ $? -ne 0 ]; then
        echo "Problem $PROBLEM_FILE timed out or exited with an error."
        # Continue to the next problem even if the previous one failed
        continue
    fi

    echo "Successfully solved problem: $PROBLEM_FILE"
done

echo "All problems processed."