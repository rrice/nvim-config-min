# Neovim Configuration

This is my opinionated Neovim configuration for development. It uses Neovim's
built-in `vim.pack` for plugins and native LSP and completion APIs, with Mason
for installing language servers and tools. It does not use Lazy.

## Requirements

- Neovim 0.12 or newer.

This configuration also enables the experimental Neovim UI2 interface.

Biome receives the current file path when formatting, allowing it to discover
the configuration for that project instead of forcing a global config.

## First-Time Setup

Mason tools are not installed automatically on startup. After opening Neovim for
the first time, run `:MasonToolsInstall` to install the configured language
servers and formatters. Run `:TSInstallConfigured` to install the configured
Treesitter parsers.

## How I Use It

I clone this outside the standard `$HOME/.config` area so that I can continuously
improve it.

Pick a location for the repository, for example:

```sh
cd "$HOME/src"
git clone https://github.com/rrice/nvim-config-min.git
```

Set `NVIM_APPNAME` to the config directory name when starting Neovim:

```sh
alias my-nvim='NVIM_APPNAME=nvim-config-min nvim'
```

To use the alias in future sessions, add it to your shell startup file, such as
`$HOME/.bashrc`.
