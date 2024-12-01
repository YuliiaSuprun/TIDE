# TIDE: A Trace-Informed Depth-First Exploration

This repository contains the implementation of **TIDE (Trace-Informed Depth-First Exploration)**, a novel planner designed to solve tasks in general planning domains defined in PDDL format with LTL$_f$ (Linear Temporal Logic on finite traces) goals. TIDE decomposes the temporal planning problem into a sequence of classical planning subproblems and leverages off-the-shelf planners for efficient execution. 
## Installation
1. Ensure you have a C++17-compatible compiler installed.
2. Installing Required Libraries:
   * **Spot Library**: Install the Spot library using the following command:
     ```
     conda create --name spotenv python=3.8 # adjust as desired
     conda activate spotenv
     conda install -c conda-forge spot
     ```
     For detailed installation instructions, [click here](https://spot.lre.epita.fr/install.html).
   * **Graphviz**: This is required for automaton visualization. You can run the following (if you use conda environment).
     ```
     conda install -c conda-forge graphviz
     ```
     You can also use other method to install it based on your OS: [click here for details](https://graphviz.org/download/).
   * **SFML Library**: Install the SFML library, which is used for grid-world visualization. You can typically install it using your system's package manager.
     For MacOS, you can use Homebrew:
     ```
     brew install sfml
     ```
3. Configuring the Makefile\
   For the provided Makefile to work properly, you should adjust some paths to match the locations of libraries on your system. Here are the lines you should check and potentially modify:
   ```
   CXXFLAGS = ... -I$(HOME)/miniconda3/envs/spotenv/include -I/usr/local/include
   LDFLAGS = ... -L$(HOME)/miniconda3/envs/spotenv/lib ... -L/usr/local/lib
   ```
   * **Spot Library**:\
      If you installed Spot using a method other than conda, or if you installed it in a different conda environment than spotenv, you'll need to adjust the include (-I) and library (-L) paths in CXXFLAGS and LDFLAGS respectively:
     * Modify the path in **-I$(HOME)/miniconda3/envs/spotenv/include** to point to where Spot's header files are located on your system.
     * Similarly, adjust **-L$(HOME)/miniconda3/envs/spotenv/lib** to point to where Spot's library files are.
   * **SFML Library**:\
     The Makefile assumes SFML is installed in /usr/local/lib. If you installed it elsewhere, modify **-L/usr/local/lib** in LDFLAGS to point to the correct location.

Once you've made these adjustments, you should be able to run ```make``` to compile the project.

4. Adjusting the **run.sh** File\
Before executing your program with run.sh, ensure the script knows where to find the dynamic libraries used by the program.\
Here's what you need to adjust:

In the run.sh file, there's a line:
```
export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:$HOME/miniconda3/envs/spotenv/lib
```
This sets the dynamic linker to search for dynamic libraries in the specified path. Adjust the path $HOME/miniconda3/envs/spotenv/lib if you installed Spot in a different location or using a different conda environment than **spotenv**.\
After making this adjustment, grant execute permissions to the run.sh script using:
```
chmod +x run.sh
```

## Usage
1. Clean and compile:
```
make clean
make
```
2. **Running TIDE method** (my method)
* on a specific PDDL problem
```
./scripts/run_single.sh data/deterministic/LTLf/TB15/blocksworld/domain.pddl data/deterministic/LTLf/TB15/blocksworld/a03.pddl 3 -f -h --save_dfa --planner fd --search lama-full
```
* on all PDDL problems in the directory
```
./scripts/run_all_in_dir.sh data/deterministic/LTLf/TB15/blocksworld 3 -f -h --save_dfa --planner astar
```
2. **Running other methods** (p4p, exp, poly)
* on a specific PDDL problem
```
./scripts/run_others_single.sh data/deterministic/LTLf/TB15/blocksworld/domain.pddl data/deterministic/LTLf/TB15/blocksworld/a03.pddl 3 --method exp --search lama-first
```
```
./scripts/run_others_single.sh data/deterministic/PPLTL/TB15/blocksworld/domain.pddl data/deterministic/PPLTL/TB15/blocksworld/a03.pddl 3 --method plan4past --search lama-first --goal data/deterministic/PPLTL/TB15/blocksworld/blocksworld_teg.json
```
* on all PDDL problems in the directory
```
./scripts/run_others_all_in_dir.sh data/deterministic/LTLf/TB15/blocksworld 3 --method exp --search lama-first
```
```
./run_others_all_in_dir.sh /home/pack-a-punch/Documents/Programming/yuliia/ResearchCode/Task-Planning-with-TEGs/Plan4Past-data/deterministic/LTLf/TB15/blocksworld 1 --method exp
```
```
./scripts/run_others_all_in_dir.sh data/deterministic/PPLTL/TB15/blocksworld 3 --method plan4past --search lama-first --goal data/deterministic/PPLTL/TB15/blocksworld/blocksworld_teg.json
```
