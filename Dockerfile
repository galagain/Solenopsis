# Base image: Ubuntu 22.04
# FROM ubuntu:22.04

# Base image: NVIDIA CUDA 12.1
FROM nvidia/cuda:12.0.1-runtime-ubuntu20.04

# Update package list, install wget, clean up to reduce image size
RUN apt-get update && apt-get install -y wget && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /root

# Add Miniconda to PATH
ENV PATH="/root/miniconda3/bin:${PATH}"

# Download and install Miniconda, then remove the installer
RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh

# Initialize conda for bash shell
RUN conda init bash

# Copy environment and project files to the working directory
COPY environment.yml pyproject.toml main.py ./

# Create a conda environment from the file
RUN conda env create -f environment.yml

# Create a script to update Poetry within the conda environment
RUN echo "source /root/miniconda3/etc/profile.d/conda.sh && conda activate solenopsis_env && poetry update" > /root/update_poetry.sh

# Execute the script to update Poetry
RUN /bin/bash /root/update_poetry.sh

# Add command to .bashrc to activate conda environment on shell start
RUN echo "source /root/miniconda3/etc/profile.d/conda.sh && conda activate solenopsis_env" >> /root/.bashrc

# Set entrypoint to activate conda environment on container start
ENTRYPOINT [ "/bin/bash", "-c", "source /root/.bashrc && /bin/bash" ]