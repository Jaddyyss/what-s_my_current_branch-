# Git Branch Display

A lightweight Godot 4 editor plugin that shows your current Git branch directly in the editor toolbar. Useful for when you're juggling multiple branches and want a quick visual reminder of where you are without alt-tabbing to GitHub Desktop, the terminal, or your file explorer.

The branch name updates automatically every 3 seconds, and you can click the toolbar button to force an immediate refresh.

## Requirements

### Godot
- **Godot 4.x** (uses `@tool`, `path_join`, and other 4.x APIs)

### Git
- **Git must be installed and available on your system PATH.**
  Test this by opening a terminal and running:
  ```
  git --version
  ```
  If it prints a version number, you're good. If it errors with "command not found" or "not recognized," install Git:
  - **Windows:** [Git for Windows](https://git-scm.com/download/win) — the standard installer adds git to PATH automatically.
  - **macOS:** `brew install git` or install via [git-scm.com](https://git-scm.com/download/mac).
  - **Linux:** `sudo apt install git` (Debian/Ubuntu), `sudo dnf install git` (Fedora), etc.

  > **Note for GitHub Desktop users:** GitHub Desktop bundles its own copy of git but does not add it to PATH. You still need to install Git separately (or set up GitHub Desktop's bundled git on your PATH manually).

### Repository Structure
- Your Godot project must live **inside a Git repository**. The plugin auto-detects the repo root using `git rev-parse --show-toplevel`, so it doesn't matter whether `.git` sits next to `project.godot` or several folders above it — as long as the project is somewhere inside a git repo, it will work.

  To check that your project is inside a repo, open a terminal in the project folder and run:
  ```
  git rev-parse --show-toplevel
  ```
  If it prints a path, you're set. If it says "fatal: not a git repository," you need to either clone an existing repo or initialize a new one (via `git init` or by adding the folder as a repository in GitHub Desktop).

## Installation

1. Copy the plugin folder into your project's `addons/` directory. The structure should look like:
   ```
   your_project/
   ├── addons/
   │   └── git_branch_display/
   │       ├── plugin.cfg
   │       ├── plugin.gd
   │       └── toolbar.tscn (and toolbar.gd)
   ├── project.godot
   └── ...
   ```

2. Open your project in Godot.

3. Go to **Project → Project Settings → Plugins**.

4. Find **Git Branch Display** in the list and check the **Enable** box.

5. The current branch name should now appear on a button in the editor toolbar.

## Usage

- The branch name updates automatically every 3 seconds.
- Click the toolbar button to force an immediate refresh.
- If the plugin shows `no git`, it means git isn't on your PATH or your project isn't inside a git repository — see the Requirements section above.

## Troubleshooting

| Display | Meaning | Fix |
|---|---|---|
| `no git` | Git isn't installed/on PATH, or project isn't in a repo | Install Git, or initialize the repo |
| `no HEAD` | Repo root was found but `.git/HEAD` is missing | Repo may be corrupted; check `.git` folder |
| `error` | Couldn't open `.git/HEAD` for reading | Check file permissions |


## How It Works

On each refresh, the plugin runs `git -C <project_path> rev-parse --show-toplevel` to find the repository root, then reads `.git/HEAD` directly to determine the current branch. This works the same regardless of which Git client you use (GitHub Desktop, command line, Fork, GitKraken, etc.) because they all update the same underlying `.git/HEAD` file.
