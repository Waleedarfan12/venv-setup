#!/bin/bash

# Safety settings
set -e  # Exit immediately if a command fails
set -u  # Treat unset variables as errors
set -o pipefail  # Fail if any command in a pipeline fails

# Color codes
INFO="\033[1;34m[INFO]\033[0m"
SUCCESS="\033[1;32m[SUCCESS]\033[0m"
WARNING="\033[1;33m[WARNING]\033[0m"
ERROR="\033[1;31m[ERROR]\033[0m"

VENV_DIR=".venv"
LOG_FILE="setup.log"

# Logging helper

log() {
    local level="$1"
    local message="$2"
    # Print to terminal with color
    echo -e "$level $message"
    # Write plain text to log file
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $level $message" >> "$LOG_FILE"
}

# Functions

check_and_create_venv() {
    if [ -d "$VENV_DIR" ]; then
        log "$INFO" "Virtual environment found. Activating..."
    else
        log "$WARNING" "No virtual environment found. Creating one..."
        python3 -m venv "$VENV_DIR" || { log "$ERROR" "Failed to create virtual environment."; exit 1; }
        log "$SUCCESS" "Virtual environment created."
    fi
    source "$VENV_DIR/bin/activate"
    log "$SUCCESS" "Virtual environment activated."
}

upgrade_pip() {
    log "$INFO" "Upgrading pip to the latest version..."
    python -m pip install --upgrade pip && log "$SUCCESS" "Pip upgraded successfully."
    log "$INFO" "Pip version after upgrade: $(pip --version)"
}

generate_gitignore() {
    if [ -f ".gitignore" ]; then
        log "$WARNING" ".gitignore already exists. Skipping creation."
    else
        log "$INFO" "Creating .gitignore with standard Python rules..."
        cat > .gitignore <<EOL
# Python virtual environment
.venv/

# Byte-compiled / optimized / DLL files
__pycache__/
*.py[cod]
*$py.class

# Distribution / packaging
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
*.egg-info/
.installed.cfg
*.egg

# Unit test / coverage reports
htmlcov/
.tox/
.nox/
.coverage
.coverage.*
.cache
nosetests.xml
coverage.xml
*.cover
*.py,cover
.hypothesis/
.pytest_cache/

# Jupyter Notebook
.ipynb_checkpoints

# VS Code
.vscode/

# Logs
*.log
EOL
        log "$SUCCESS" ".gitignore created."
    fi
}

install_default_packages() {
    log "$INFO" "Installing default Python packages (pandas, requests)..."
    pip install pandas requests && log "$SUCCESS" "Default packages installed successfully."
}


# Main function

main() {
    # Ensure the script is sourced
    if [ "$0" = "$BASH_SOURCE" ]; then
        log "$ERROR" "Please run this script with: source setup.sh"
        exit 1
    fi

    # Start fresh log file
    echo "===== Setup started at $(date '+%Y-%m-%d %H:%M:%S') =====" > "$LOG_FILE"

    check_and_create_venv
    upgrade_pip
    generate_gitignore
    install_default_packages

    log "$SUCCESS" "Setup completed successfully."
}

# Run main
main
