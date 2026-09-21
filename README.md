# uv-env-manager

A simple interactive CLI for managing [`uv`](https://github.com/astral-sh/uv) virtual environments on Ubuntu and Linux.

It gives you a numbered menu to create, list, select, and remove environments, while keeping them in one central location.

## Quick install

```bash
curl -fsSL https://raw.githubusercontent.com/v0ntr3n/uv-env-manager/main/install_av.sh | bash
```

Then run:

```bash
av
```

The installer will:

* install `uv` if it is not already installed
* download the latest `av` script from this repository
* install `av` into your PATH
* create the default virtual environment directory

If running as root, `av` is installed to:

```text
/usr/local/bin/av
```

For a normal user, it is installed to:

```text
~/.local/bin/av
```

## Usage

Run:

```bash
av
```

You will see an interactive menu similar to:

```text
+--------------------------------------------------+
|          UV VIRTUAL ENVIRONMENT TOOL             |
|  ~/.local/share/uv_venv
+--------------------------------------------------+

  Environments:

    [1] project1 (Python 3.12.x)
    [2] test     (Python 3.11.x)

    [0]  Create new environment
    [q]  Quit

  Your choice:
```

Select an environment by number to open a shell with that virtual environment activated.

The activated environment runs in a child shell, so your original shell stays unchanged. To return to it, run:

```bash
exit
```

## Create a virtual environment

Run:

```bash
av
```

Select:

```text
0
```

Then enter a name and Python version:

```text
Name: cloak
Version: 3.12
```

This is equivalent to:

```bash
uv venv --python 3.12 ~/.local/share/uv_venv/cloak
```

If the requested Python version is not installed, `uv` can download it automatically.

## Commands

### Interactive mode

```bash
av
```

### List environments

```bash
av list
```

### Create an environment

```bash
av create myenv
```

Or use interactive mode to choose the Python version:

```bash
av
```

### Open an activated environment

```bash
av shell myenv
```

### Show environment path

```bash
av path myenv
```

### Remove an environment

```bash
av remove myenv
```

### Show help

```bash
av help
```

## Environment location

By default, virtual environments are stored in:

```text
~/.local/share/uv_venv
```

You can change this using `AV_ENV_ROOT`.

Example:

```bash
export AV_ENV_ROOT="$HOME/uv_venv"
av
```

To make it permanent:

```bash
echo 'export AV_ENV_ROOT="$HOME/uv_venv"' >> ~/.bashrc
source ~/.bashrc
```

For Zsh:

```bash
echo 'export AV_ENV_ROOT="$HOME/uv_venv"' >> ~/.zshrc
source ~/.zshrc
```

## Manual installation

Clone the repository:

```bash
git clone https://github.com/v0ntr3n/uv-env-manager.git
cd uv-env-manager
```

Make the scripts executable:

```bash
chmod +x av install_av.sh
```

Install:

```bash
./install_av.sh
```

Then run:

```bash
av
```

## Updating

To update manually:

```bash
curl -fsSL https://raw.githubusercontent.com/v0ntr3n/uv-env-manager/main/install_av.sh | bash
```

The installer downloads the latest `av` script from GitHub and replaces the installed version.

## Uninstall

If installed system-wide:

```bash
sudo rm -f /usr/local/bin/av
```

If installed for the current user:

```bash
rm -f ~/.local/bin/av
```

Your virtual environments are not removed automatically.

To remove them as well:

```bash
rm -rf ~/.local/share/uv_venv
```

## Requirements

* Ubuntu or another Linux distribution
* Bash
* `curl`
* internet access for installing `uv` and downloading the script

`uv` itself is installed automatically if it is missing.

## Example workflow

```bash
# Install
curl -fsSL https://raw.githubusercontent.com/v0ntr3n/uv-env-manager/main/install_av.sh | bash

# Open manager
av

# Or create directly
av create project1

# Open it
av shell project1

# Check Python
python --version

# Leave environment
exit

# List all environments
av list
```

## Repository

```text
https://github.com/v0ntr3n/uv-env-manager
```

## License

No license has been selected yet.
