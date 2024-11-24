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
    && apt-get clean

# Install Miniconda (lightweight Anaconda version)
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/miniconda && \
    rm Miniconda3-latest-Linux-x86_64.sh

# Add Miniconda to PATH
ENV PATH="/opt/miniconda/bin:$PATH"

# Create a new Conda environment and install Spot
RUN /opt/miniconda/bin/conda create --name spotenv python=3.8 -y && \
    /opt/miniconda/bin/conda run -n spotenv conda install -c conda-forge spot -y

# Install Plan4Past from PyPI
RUN pip3 install plan4past

# Download and install Boost 1.82.0 from source
WORKDIR /tmp
RUN wget https://boostorg.jfrog.io/artifactory/main/release/1.82.0/source/boost_1_82_0.tar.gz && \
    tar -xvzf boost_1_82_0.tar.gz && \
    cd boost_1_82_0 && \
    ./bootstrap.sh && \
    ./b2 install --prefix=/usr/local
    
# Set the working directory
WORKDIR /app

# Copy the entire project into the container
COPY . /app

# Set LD_LIBRARY_PATH for the libraries
ENV LD_LIBRARY_PATH=/usr/local/lib:/app/lib:/opt/miniconda/envs/spotenv/lib:/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH

# Build the project using the Makefile
RUN /opt/miniconda/bin/conda run -n spotenv make

# No default command; specify executable and arguments at runtime
