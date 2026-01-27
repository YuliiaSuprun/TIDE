# Use the official Ubuntu 22.04 base image
FROM ubuntu:22.04

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    build-essential \
    cmake \
    libboost-all-dev \
    libz3-dev \
    libsfml-dev \
    graphviz libgraphviz-dev \
    nlohmann-json3-dev \
    bison autoconf \
    python3 \
    python3-pip \
    mona \
    swi-prolog \
    libncurses5 \
    libncurses6 \
    libtinfo6 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Miniconda (architecture-aware)
RUN ARCH=$(uname -m) && \
    if [ "$ARCH" = "x86_64" ]; then \
        MINICONDA=Miniconda3-latest-Linux-x86_64.sh; \
    else \
        MINICONDA=Miniconda3-latest-Linux-aarch64.sh; \
    fi && \
    wget https://repo.anaconda.com/miniconda/$MINICONDA && \
    bash $MINICONDA -b -p /opt/miniconda && \
    rm $MINICONDA

# Configure Conda and accept ToS
RUN /opt/miniconda/bin/conda config --system --set always_yes true && \
    /opt/miniconda/bin/conda config --system --set changeps1 false && \
    /opt/miniconda/bin/conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main && \
    /opt/miniconda/bin/conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r

# Environment variables
ENV LD_LIBRARY_PATH=/app/lib:/app/pddlboat/build/release:/usr/local/lib:/usr/lib:/opt/miniconda/envs/spotenv/lib:${LD_LIBRARY_PATH:-}
ENV FAST_DOWNWARD_BASE_PATH=/app/pddlboat/submodules/downward
ENV PATH="/opt/miniconda/bin:/opt/miniconda/envs/spotenv/bin:/app/pddlboat/submodules/downward:$PATH"

# Create Conda environment and install Spot
RUN /opt/miniconda/bin/conda create --name spotenv python=3.8 && \
    /opt/miniconda/bin/conda run -n spotenv conda install -c conda-forge spot && \
    /opt/miniconda/bin/conda clean -afy

# Install Plan4Past
RUN pip3 install plan4past

# Build Boost 1.82 library
WORKDIR /tmp
RUN wget https://archives.boost.io/release/1.82.0/source/boost_1_82_0.tar.gz && \
    tar -xvzf boost_1_82_0.tar.gz && \
    cd boost_1_82_0 && \
    ./bootstrap.sh && \
    ./b2 install --prefix=/usr/local cxxstd=17 cxxflags="-std=c++17" && \
    rm -rf /tmp/boost_1_82_0 /tmp/boost_1_82_0.tar.gz

# Set working directory
WORKDIR /app

# Copy project
COPY . /app

# Build Fast Downward
WORKDIR /app/pddlboat/submodules/downward
RUN apt-get update && apt-get install -y cmake g++ make python3 && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    python3 build.py && \
    ./fast-downward.py --help

# Build pddlboat
WORKDIR /app/pddlboat
RUN mkdir -p build/release && cd build/release && cmake ../.. && make

# Install FOND4LTLf and dependencies
WORKDIR /app
RUN /opt/miniconda/bin/conda run -n spotenv conda install pip && \
    /opt/miniconda/bin/conda run -n spotenv pip install --upgrade pip setuptools wheel && \
    /opt/miniconda/bin/conda run -n spotenv pip install ltlf2dfa click ply && \
    cd /app/benchmarking/baselines/FOND4LTLf && \
    /opt/miniconda/bin/conda run -n spotenv pip install .

# Build project using Makefile
RUN /opt/miniconda/bin/conda run -n spotenv make

# No default CMD
