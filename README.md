# Python Project Setup Script

This repository includes a Bash script (`setup.sh`) that automates the setup of a Python development environment.  
It ensures a consistent workflow by creating a virtual environment, upgrading `pip`, generating a `.gitignore`, and installing default packages.

---

## 🚀 Features
- **Safety-first execution**  
  - `set -e` → Exit immediately if a command fails  
  - `set -u` → Treat unset variables as errors  
  - `set -o pipefail` → Fail if any command in a pipeline fails  

- **Logging with colors**  
  - Informational, success, warning, and error messages are printed with colors.  
  - All logs are also saved to `setup.log`.

- **Virtual environment management**  
  - Checks if `.venv` exists.  
  - Creates and activates a new virtual environment if missing.  

- **Pip upgrade**  
  - Upgrades `pip` to the latest version.  
  - Displays the upgraded version.  

- **.gitignore generation**  
  - Creates a `.gitignore` file with standard Python rules if one doesn’t already exist.  

- **Default package installation**  
  - Installs `pandas` and `requests` automatically.  

---

## 📂 Files
- `setup.sh` → The main setup script.  
- `setup.log` → Log file generated during execution.  
- `.gitignore` → Standard Python `.gitignore` (created if missing).  

---

## ⚙️ Usage
Run the script with:

```bash
source setup.sh
