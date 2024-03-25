#!/bin/bash

# Check if user is root. If it is, tell the user it must NOT be root and exit with code 1

function check_root {
    if [ "$EUID" -eq 0 ]
    then 
        echo "You must NOT be root to run this script."
        exit 1
    fi
}

# Check if Ubuntu version is 20.04 (focal). If it is not, print "Incorrect version. Run this script only on Ubuntu 20.04 (focal)" and exit with code 1

function check_version {
    if [ "$(lsb_release -cs)" != "focal" ]
    then
        echo "Incorrect version. Run this script only on Ubuntu 20.04 (focal)"
        exit 1
    fi
}

# Update and upgrade the system

function update_upgrade {
    sudo apt-get update && sudo apt-get upgrade -y
}

# Insstall git

function install_git {
    sudo apt-get update && sudo apt-get install git -y
}

# Clone the privateGPT repository

function clone_privateGPT {
    cd $HOME
    git clone https://github.com/imartinez/privateGPT
}

# Set up Python environment

function setup_python {
    sudo apt-get install gcc make openssl libssl-dev libbz2-dev libreadline-dev libsqlite3-dev \
         zlib1g-dev libncursesw5-dev libgdbm-dev libc6-dev zlib1g-dev libsqlite3-dev tk-dev    \
         libssl-dev openssl libffi-dev -y
    curl https://pyenv.run | bash
    export PATH="/home/$(whoami)/.pyenv/bin:$PATH"
}

# Set up automatic activation of pyenv

function setup_pyenv {
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> $HOME/.bashrc
    echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> $HOME/.bashrc
    echo 'eval "$(pyenv init -)"' >> $HOME/.bashrc
    source $HOME/.bashrc
}

# Install lzma and liblzma-dev

function install_lzma {
    sudo apt-get update && sudo apt-get install lzma liblzma-dev -y
}

# Install and set up Python 3.11 and set it up as the default Python version

function install_python {
    pyenv install 3.11
    pyenv global 3.11
    pip install pip --upgrade
    pyenv local 3.11
}

# Install and set up poetry

function install_poetry {
    curl -sSL https://install.python-poetry.org | python3 -
    echo 'export PATH="/home/$(whoami)/.local/bin:$PATH"' >> $HOME/.bashrc
    source $HOME/.bashrc
}

# Check poetry version and display it

function check_poetry_version {
    poetry --version
}

# Install the dependencies for privateGPT

function install_privateGPT_dependencies {
    cd $HOME/privateGPT
    poetry install --extras "ui embeddings-huggingface llms-llama-cpp vector-stores-qdrant"
}

# nVidia drivers installation

function install_nvidia_drivers {
    mkdir $HOME/nvidia
    cd $HOME/nvidia
    wget https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-keyring_1.1-1_all.deb
    sudo dpkg -i cuda-keyring_1.1-1_all.deb
    sudo apt-get update
    sudo apt-get -y install cuda-toolkit-12-4

    # Post installation tasks
    echo 'export PATH="/usr/local/cuda-12.4/bin:$PATH"' >> $HOME/.bashrc
    echo 'export LD_LIBRARY_PATH="/usr/local/cuda-12.4/lib64:$LD_LIBRARY_PATH"' >> $HOME/.bashrc
}

# Reload and check nVidia drivers

function reload_nvidia_drivers {
    source $HOME/.bashrc
    nvcc --version
    nvidia-smi.exe
}

# Instal LLAMA CUDA libraries and Python bindings

function install_llama {
    CMAKE_ARGS='-DLLAMA_CUBLAS=on' poetry run pip install --force-reinstall --no-cache-dir llama-cpp-python
}

# Download LLM model (mixtral)

function download_llm_model {
    poetry run python scripts/setup
}

# Ask the user if they want to start the GPT. If they answer 'Y', start it up

function start_gpt {
    echo "Do you want to start the GPT? (Y/N)"
    read answer
    if [ "$answer" == "Y" ]
    then
        cd $HOME/privateGPT
        make run
    fi
}

# Main function

function main {
    check_root
    check_version
    update_upgrade
    install_git
    clone_privateGPT
    setup_python
    setup_pyenv
    install_lzma
    install_python
    install_poetry
    check_poetry_version
    install_privateGPT_dependencies
    install_nvidia_drivers
    reload_nvidia_drivers
    install_llama
    download_llm_model
    start_gpt
}

main

# End of script

# Usage: bash install-privateGPT-on-wsl.sh
```