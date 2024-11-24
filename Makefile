CXX = g++

CXXFLAGS = -std=c++17 -Wall -Wextra -O3 -march=native -flto -DNDEBUG \
           -Iinclude/domain -Iinclude/ltl \
		   -I$(HOME)/anaconda3/envs/spotenv/include \
           -I/usr/include -Ipddlboat/include

# Linker flags (directories to search for libraries)
LDFLAGS = -L$(HOME)/anaconda3/envs/spotenv/lib \
          -L/usr/lib/x86_64-linux-gnu \
          -Lpddlboat/build/release \
		  -L/usr/local/lib -flto

# Libraries to link against
LDLIBS = -lspot -lbddx -lgvc -lcgraph \
         -lsfml-graphics -lsfml-window -lsfml-system \
		 -lboost_system -lboost_chrono \
         -lpddlboat-cpp

# Directories for object files and executables
OBJDIR = lib
BINDIR = bin

# Source files for each target
SRC_COMMON = src/ltl/TEGProblem.cpp src/ltl/DFANode.cpp \
             src/ltl/DFAManager.cpp src/ltl/ProductManager.cpp \
             src/ltl/DomainManager.cpp \
             src/domain/GridWorldDomain.cpp src/domain/GridWorldPlotter.cpp \
             src/domain/PDDLDomain.cpp src/domain/PDDLProblem.cpp \
             src/domain/PDDLAction.cpp src/domain/PDDLState.cpp

SRC_MAIN_SINGLE = src/main/main_single.cpp $(SRC_COMMON)
SRC_MAIN_SINGLE_OTHERS = src/main/main_single_others.cpp $(SRC_COMMON)
SRC_MAIN_ALL_IN_DIR = src/main/main_all.cpp $(SRC_COMMON)
SRC_MAIN_ALL_IN_DIR_OTHERS = src/main/main_all_in_dir_others.cpp $(SRC_COMMON)

# Automatically generate object file names in the lib directory
OBJ_MAIN_SINGLE = $(patsubst %.cpp,$(OBJDIR)/%.o,$(SRC_MAIN_SINGLE))
OBJ_MAIN_SINGLE_OTHERS = $(patsubst %.cpp,$(OBJDIR)/%.o,$(SRC_MAIN_SINGLE_OTHERS))
OBJ_MAIN_ALL_IN_DIR = $(patsubst %.cpp,$(OBJDIR)/%.o,$(SRC_MAIN_ALL_IN_DIR))
OBJ_MAIN_ALL_IN_DIR_OTHERS = $(patsubst %.cpp,$(OBJDIR)/%.o,$(SRC_MAIN_ALL_IN_DIR_OTHERS))


# Header files
HEADERS = include/ltl/LTLFormula.h include/domain/GridState.h \
          include/domain/GridAction.h include/domain/GridWorldDomain.h \
          include/ltl/TEGProblem.h include/ltl/ProductState.h \
          include/domain/GridWorldPlotter.h include/domain/Action.h \
          include/domain/CompoundAction.h include/domain/PrimitiveAction.h \
          include/ltl/DFANode.h include/ltl/DFAManager.h \
          include/ltl/DomainManager.h include/ltl/ProductManager.h \
          include/domain/Domain.h include/domain/PDDLDomain.h \
          include/domain/PDDLProblem.h include/domain/PDDLAction.h \
          include/domain/PDDLState.h

# Executable targets
TARGET = $(BINDIR)/main_single $(BINDIR)/main_single_others \
         $(BINDIR)/main_all $(BINDIR)/main_all_in_dir_others

# Default rule: build all targets
all: $(BINDIR) $(TARGET)

# Rule to create the bin directory if it doesn't exist
$(BINDIR):
	@mkdir -p $(BINDIR)

# Rules to build each target
$(BINDIR)/main_single: $(OBJ_MAIN_SINGLE)
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)

$(BINDIR)/main_single_others: $(OBJ_MAIN_SINGLE_OTHERS)
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)

$(BINDIR)/main_all: $(OBJ_MAIN_ALL_IN_DIR)
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)

$(BINDIR)/main_all_in_dir_others: $(OBJ_MAIN_ALL_IN_DIR_OTHERS)
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)


# Pattern rule to compile .cpp files into .o files
$(OBJDIR)/%.o: %.cpp $(HEADERS)
	@mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) -MMD -c $< -o $@


# Include dependencies
-include $(OBJ_MAIN_SINGLE:.o=.d)
-include $(OBJ_MAIN_SINGLE_OTHERS:.o=.d)
-include $(OBJ_MAIN_ALL_IN_DIR:.o=.d)
-include $(OBJ_MAIN_ALL_IN_DIR_OTHERS:.o=.d)

# Clean up
clean:
	rm -rf $(OBJDIR) $(BINDIR) *.d

.PHONY: all clean

