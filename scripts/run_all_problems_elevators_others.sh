#!/bin/bash

# Set the base directory path for your problems and domain file
BASE_DIR="/app/data/deterministic/LTLf/BF23/elevators"
DOMAIN_FILE="$BASE_DIR/domain.pddl"

# Iterate from s2 to s30
for i in {2..30}; do
    PROBLEM_FILE="$BASE_DIR/s${i}-0.pddl"
    echo "Solving problem: $PROBLEM_FILE"

    # Call the single problem solver
    /app/bin/main_single_others "$DOMAIN_FILE" "$PROBLEM_FILE" 1 --method "$@" --timeout 3600 --goal "$BASE_DIR/elevators_teg.json" --search lama-first

    # Check the exit code of the previous command
    if [ $? -ne 0 ]; then
        echo "Problem $PROBLEM_FILE timed out or exited with an error."
        # Continue to the next problem even if the previous one failed
        continue
    fi

    echo "Successfully solved problem: $PROBLEM_FILE"
done

echo "All problems processed."