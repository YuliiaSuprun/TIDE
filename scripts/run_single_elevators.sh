#!/bin/bash

# Check if the problem number is provided as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 <problem_number>"
    echo "Please provide a problem number between 2 and 30."
    exit 1
fi

# Validate that the argument is a number between 2 and 30
if ! [[ "$1" =~ ^[0-9]+$ ]] || [ "$1" -lt 2 ] || [ "$1" -gt 30 ]; then
    echo "Error: Problem number must be an integer between 2 and 30."
    exit 1
fi

# Set the base directory path for your problems and domain file
BASE_DIR="$HOME/Documents/Programming/yuliia/ResearchCode/Task-Planning-with-TEGs/docker_dir/data/deterministic/LTLf/BF23/elevators"
DOMAIN_FILE="$BASE_DIR/domain.pddl"

# Get the problem number from the command-line argument
PROBLEM_NUMBER=$1
PROBLEM_FILE="$BASE_DIR/s${PROBLEM_NUMBER}-0.pddl"
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