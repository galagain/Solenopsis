# docker-conda-poetry-environment

## Introduction
This repository provides a Docker configuration utilizing Conda and Poetry for Python environment and dependency management. The environment is pre-configured to support CUDA, enabling code execution across different CUDA versions regardless of the host machine's installed CUDA version.

## Prerequisites
- Docker installed on your machine

## File Structure
- environment.yml: Conda environment specification
- pyproject.toml: Poetry configuration for dependency management
- Dockerfile: Docker image definition
- main.py: A Python script demonstrating the use of PyTorch to check CUDA version and availability

## Cloning the Repository
Before building the Docker image, you must first clone the repository containing the necessary project files. Use the following command to clone the repository:

```bash
git clone https://github.com/galagain/Solenopsis.git
cd Solenopsis
```
Ensure you navigate into the main directory of the cloned repository where the Dockerfile and other project files are located.

## Building the Docker Image
To build the Docker image, run the following command in the directory containing the Dockerfile:

```bash
docker build -t solenopsis_v1 .
```
This command builds a Docker image named solenopsis_v1 following the instructions defined in the Dockerfile.

## Running the Docker Container
To run the Docker container using the built image, with GPU support and mounting a volume for data, use the following command:

```bash
docker run -it --gpus all -v /database2/odometry:/root/datasets solenopsis_v1
```
This starts the solenopsis_v1 container in interactive mode (-it), enables GPU support (--gpus all), and mounts the host machine's /database2/odometry directory to /root/datasets in the container. The Dockerfile configuration ensures the Conda environment is automatically activated when the container starts, allowing for immediate execution of Python scripts in the predefined environment.

## Using the Environment
Once inside the container, you can execute commands as if you were in a Conda environment with Poetry. Here are some useful commands:

- List files to verify mounted volumes:
  ```bash
  ls
  ```

- Run the Python script main.py to test CUDA availability and display its version:
  ```bash
  python main.py
  ```
