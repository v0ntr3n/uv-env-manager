# uv-env-manager

A small Ubuntu/Linux command-line utility for managing Python virtual environments with [uv](https://github.com/astral-sh/uv).

## Features

- Interactive environment selector
- Create environments with a chosen Python version
- List existing environments and Python versions
- Open an activated shell
- Remove environments
- Configurable environment storage directory
- Installer that installs `uv` when needed

## Install

```bash
git clone https://github.com/v0ntr3n/uv-env-manager.git
cd uv-env-manager
chmod +x install_av.sh
./install_av.sh
```

If running as root, `av` is installed to:

```text
/usr/local/bin/av
```

Otherwise it is installed to:

```text
~/.local/bin/av
```

The installer also installs `uv` if it is not already available.

## Usage

Run the interactive interface:

```bash
av
```

Other commands:

```bash
av list
av create myenv
av path myenv
av shell myenv
av remove myenv
av help
```

## Environment location

By default, environments are stored in:

```text
~/.local/share/uv_venv
```

Override this with:

```bash
export AV_ENV_ROOT="$HOME/uv_venv"
```

You can add that line to `~/.bashrc` or `~/.zshrc`.

## Requirements

- Ubuntu/Linux
- Bash
- `curl`
- `ca-certificates`

`uv` is installed automatically by `install_av.sh` if missing.

## Files

- `av` — environment manager CLI
- `install_av.sh` — installer for `uv` and `av`
