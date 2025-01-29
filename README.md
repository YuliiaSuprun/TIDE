# TIDE: A Trace-Informed Depth-First Exploration

This repository contains the implementation of **TIDE (Trace-Informed Depth-First Exploration)**, a novel planner designed to solve tasks in general planning domains defined in PDDL format with LTLf (Linear Temporal Logic on finite traces) goals. TIDE decomposes the temporal planning problem into a sequence of classical planning subproblems and leverages off-the-shelf planners for efficient execution.

---

## Using TIDE with Docker

This guide explains how to build and use the TIDE project as a Docker container. Docker provides an isolated and consistent environment for running TIDE without worrying about installing dependencies manually.

### **Building the Docker Image**
To create the Docker image:

1. Navigate to the root of this repository:
   ```bash
   cd /path/to/TIDE
   ```
2. Build the Docker image:
   ```bash
   docker build -t tide_image .
   ```
   - Replace `tide_image` with a name of your choice for the image.

---

### **Running the Docker Container**
To start a container from the image:

1. Run the following command to open an interactive shell:
   ```bash
   docker run -it tide_image /bin/bash
   ```

2. Once inside the container, you can execute the provided scripts as described below.

---

## Running TIDE

### **Running TIDE on a Single Problem**

To run TIDE on a specific PDDL problem:

```bash
scripts/run_single.sh data/deterministic/LTLf/TB15/blocksworld/domain.pddl \
                      data/deterministic/LTLf/TB15/blocksworld/a03.pddl \
                      3 -f -h -c --planner fd --search lama-first
```

#### **Explanation of Arguments:**
- **Domain and Problem Files:**
  - `data/deterministic/LTLf/TB15/blocksworld/domain.pddl`: Path to the domain file.
  - `data/deterministic/LTLf/TB15/blocksworld/a03.pddl`: Path to the problem file.
- **Number of Runs:**
  - `3`: Specifies the number of runs for TIDE.
- **Options:**
  - `-f`: Uses feedback from failed attempts.
  - `-h`: Enables heuristics for selecting a promising DFA trace.
  - `-c`: Enables caching of successful prefixes.
- **Planner Options:**
  - `--planner`: The planner to use (`fd` for FastDownward or `astar` for A*).
  - `--search`: Specifies the search type when using `fd` (options: `lama-first`, `lama-full`).
  - **`lama-first`**: Returns the first plan found without further refinement, making it significantly faster.
  - **`lama-full`**: Also known as `seq-sat-lama-2011`, this mode refines and optimizes the first-found plan to produce a shorter and more efficient solution, but it is slower and more computationally expensive.
- **Optional Flags:**
  - `--save_dfa`: Saves the DFA as an image.

---

### **Running TIDE on All Problems in a Directory**

To run TIDE on all PDDL problems in a directory:

```bash
scripts/run_all_in_dir.sh data/deterministic/LTLf/TB15/blocksworld 3 -f -h -c --planner astar
```

#### **Explanation of Arguments:**
- **Directory Path:**
  - `data/deterministic/LTLf/TB15/blocksworld`: Path to the directory containing `domain.pddl` and problem files.
- **Other Arguments:**
  - These are the same as described for running TIDE on a single problem.

---

## Running Competitor Methods

TIDE is compared against several established frameworks:

- **FOND4LTLf**: Converts LTLf formulas into deterministic finite automata (DFA) and computes the product graph of the DFA and the domain. Originally designed for FOND domains but applicable to deterministic domains.
- **Exp**: Translates LTLf goals into nondeterministic finite automata (NFA).
- **Poly**: Uses polynomial-time techniques to convert LTLf formulas into alternating finite automata (AFA).
- **Plan4Past**: Handles temporal goals expressed in Pure-Past Linear Temporal Logic (PPLTL).

These methods use **two classical off-the-shelf planners**:
- **A***: Guarantees optimal solutions when using admissible heuristics.
- **Fast Downward with LAMA search**: Uses a cost-sensitive landmark heuristic and iterated weighted A* search. The `lama-first` mode is preferred for performance.

---

### **Running a Competitor Method on a Single Problem**

#### **Exp Method:**
```bash
scripts/run_others_single.sh data/deterministic/LTLf/TB15/blocksworld/domain.pddl \
                            data/deterministic/LTLf/TB15/blocksworld/a03.pddl \
                            3 --method exp --search lama-first
```

#### **Poly Method:**
```bash
scripts/run_others_single.sh data/deterministic/LTLf/TB15/blocksworld/domain.pddl \
                            data/deterministic/LTLf/TB15/blocksworld/a03.pddl \
                            3 --method poly --search lama-first
```

#### **Plan4Past Method:**
```bash
scripts/run_others_single.sh data/deterministic/PPLTL/TB15/blocksworld/domain.pddl \
                            data/deterministic/PPLTL/TB15/blocksworld/a03.pddl \
                            3 --method plan4past --search lama-first \
                            --goal data/deterministic/PPLTL/TB15/blocksworld/blocksworld_teg.json
```

#### **FOND4LTLf Method:**
```bash
scripts/run_others_single.sh data/deterministic/FOND4LTLf/TB15/blocksworld/domain.pddl \
                            data/deterministic/FOND4LTLf/TB15/blocksworld/a03.pddl \
                            3 --method fond4ltlf --search lama-first \
                            --goal data/deterministic/FOND4LTLf/TB15/blocksworld/blocksworld_teg.json
```

#### **Explanation of Arguments:**
- **Domain and Problem Files:**
  - `data/deterministic/PPLTL/TB15/blocksworld/domain.pddl`: Path to the domain file.
  - `data/deterministic/PPLTL/TB15/blocksworld/a03.pddl`: Path to the problem file.
- **Number of Runs:**
  - `3`: Specifies the number of runs.
- **Method Selection:**
  - `--method plan4past`: Specifies the planning method (`exp`, `poly`, `plan4past`, `fond4ltlf`).
- **Search Strategy:**
  - `--search lama-first`: Specifies the search strategy (`lama-full`, `lama-first`).
- **Temporal Goal File:**
  - `--goal data/deterministic/PPLTL/TB15/blocksworld/blocksworld_teg.json`: Path to the goal specification JSON file. This argument is required only for `plan4past` and `fond4ltlf`.
---

### **Running a Competitor Method on All Problems in a Directory**

The scripts for running competitor methods on all problems in a directory use the same arguments as the scripts that solve a single problem. For example, to run plan4past on all problems in a directory:

```bash
scripts/run_others_all_in_dir.sh data/deterministic/PPLTL/TB15/blocksworld 3 --method plan4past \
                                --search lama-first --goal data/deterministic/PPLTL/TB15/blocksworld/blocksworld_teg.json
```

#### **Explanation of Arguments:**
- **Directory Path:**
  - `data/deterministic/PPLTL/TB15/blocksworld`: Directory containing `domain.pddl` and problem files.
- **Other Arguments:**
  - These are the same as described for running a single problem.

---

## Key Notes
- Ensure that all required PDDL files and goal JSON files are available in the specified paths.
- The Docker container provides all necessary dependencies, so you don’t need to install anything manually.
- To exit the Docker container, type:
  ```bash
  exit
  ```



