# Use the official Ubuntu 22.04 base image
FROM ubuntu:22.04

# Set environment variables to avoid interaction during package installation
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
    libncurses5 \
    libncurses6 \
    libtinfo6 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Miniconda (lightweight Anaconda version)
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/miniconda && \
    rm Miniconda3-latest-Linux-x86_64.sh

# Set LD_LIBRARY_PATH for runtime
ENV LD_LIBRARY_PATH=/app/lib:/app/pddlboat/build/release:/opt/miniconda/envs/spotenv/lib:/usr/local/lib:/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH

# Set environment variable for Fast Downward path
ENV FAST_DOWNWARD_BASE_PATH=/app/pddlboat/submodules/downward

# Create a new Conda environment and install Spot
RUN /opt/miniconda/bin/conda create --name spotenv python=3.8 -y && \
    /opt/miniconda/bin/conda run -n spotenv conda install -c conda-forge spot -y

# Install Plan4Past from PyPI
RUN pip3 install plan4past

# Download and install Boost 1.82.0 from source
WORKDIR /tmp
RUN wget https://archives.boost.io/release/1.82.0/source/boost_1_82_0.tar.gz && \
    tar -xvzf boost_1_82_0.tar.gz && \
    cd boost_1_82_0 && \
    ./bootstrap.sh && \
    ./b2 install --prefix=/usr/local && \
    rm -rf /tmp/boost_1_82_0 /tmp/boost_1_82_0.tar.gz

# Set the working directory
WORKDIR /app

# Copy the entire project into the container
COPY . /app

# Build Fast Downward planner
WORKDIR /app/pddlboat/submodules/downward
RUN apt-get update && apt-get install -y cmake g++ make python3 && apt-get clean && rm -rf /var/lib/apt/lists/* && \
    python3 build.py && \
    ./fast-downward.py --help

# Build pddlboat
WORKDIR /app/pddlboat
RUN mkdir -p build/release && cd build/release && cmake ../.. && make

# Add Miniconda and FastDownward to PATH
ENV PATH="/opt/miniconda/bin:/opt/miniconda/envs/spotenv/bin:/app/pddlboat/submodules/downward:$PATH"

WORKDIR /app

# Install FOND4LTLf and dependencies
RUN /opt/miniconda/bin/conda run -n spotenv conda install pip -y && \
    /opt/miniconda/bin/conda run -n spotenv pip install --upgrade pip setuptools wheel && \
    /opt/miniconda/bin/conda run -n spotenv pip install ltlf2dfa click ply && \
    cd /app/FOND4LTLf && \
    /opt/miniconda/bin/conda run -n spotenv pip install .

# Build the project using the Makefile
RUN /opt/miniconda/bin/conda run -n spotenv make

# No default command; specify executable and arguments at runtime
