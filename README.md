# TIDE: A Trace-Informed Depth-First Exploration

This repository contains the implementation of **TIDE (Trace-Informed Depth-First Exploration)**, a novel planner designed to solve tasks in general planning domains defined in PDDL format with LTL$_f$ (Linear Temporal Logic on finite traces) goals. TIDE decomposes the temporal planning problem into a sequence of classical planning subproblems and leverages off-the-shelf planners for efficient execution.

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

### **Running TIDE on a Single Problem**

To run TIDE on a specific PDDL problem:

```bash
scripts/run_single.sh data/deterministic/LTLf/TB15/blocksworld/domain.pddl \
                      data/deterministic/LTLf/TB15/blocksworld/a03.pddl \
                      3 -f -h -c --planner fd --search lama-first
```

#### Explanation of Arguments:
- **Domain and Problem Files**:
  - `data/deterministic/LTLf/TB15/blocksworld/domain.pddl`: Path to the domain file.
  - `data/deterministic/LTLf/TB15/blocksworld/a03.pddl`: Path to the problem file.
- **Number of Runs**:
  - `3`: Specifies the number of runs for TIDE.
- **Options**:
  - `-f`: Uses feedback from failed attempts.
  - `-h`: Enables heuristics.
  - `-c`: Enables caching.
- **Planner Options**:
  - `--planner`: The planner to use (`fd` or `astar`).
  - `--search`: Specifies the search type when using `fd` (options: `lama-first`, `lama-full`).
- **Optional Flags**:
  - `--save_dfa`: Saves the DFA as an image.

---

### **Running TIDE on All Problems in a Directory**

To run TIDE on all PDDL problems in a directory:

```bash
scripts/run_all_in_dir.sh data/deterministic/LTLf/TB15/blocksworld 3 -f -h -c --planner astar
```

#### Explanation of Arguments:
- **Directory Path**:
  - `data/deterministic/LTLf/TB15/blocksworld`: Path to the directory containing `domain.pddl` and problem files.
- **Other Arguments**:
  - These are the same as described for running TIDE on a single problem.

---

### **Key Notes**
- Ensure that all required PDDL files are available in the specified paths.
- The Docker container provides all necessary dependencies, so you don’t need to install anything manually.
- To exit the Docker container, type:
  ```bash
  exit
  ```

---

By using Docker, you can easily experiment with TIDE in a consistent and reproducible environment.

