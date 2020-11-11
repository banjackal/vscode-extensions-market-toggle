# vscode-extensions-market-toggle

A set of bash aliases and functions to help toggle between the Open VSX and Microsoft VSCode Extensions marketplaces.

## Installation

Run `./install.sh`. If you're not using `~/.bashrc` as your default bash startup driver, go ahead and pass in a path to your preferred driver file. e.g. `./install.sh /path/to/driver/file`

Script will append a `source` to your driver file so aliases will be available on terminal start.

## Usage

Run `check-market` to see which extension marketplace you are currently using between Open VSX and Microsoft.
Run `toggle-market` to switch between the two.

Changes will need a VSCode restart to be reflected in searches, updates, etc.
