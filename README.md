# Neovim Configuration

This is my opinionated Neovim configuration for development. It uses Neovim's
built-in `vim.pack` for plugins and native LSP APIs, with nvim-cmp for completion
and Mason for installing language servers and tools. It does not use Lazy.

## Requirements

- Neovim 0.12 or newer.

This configuration also enables the experimental Neovim UI2 interface.

Completion suggestions include LSP results, LuaSnip snippets, file paths, and
words from the current buffer. The Friendly Snippets collection provides
ready-made language snippets.

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

## AI-Assisted Development

AI tools may be used to understand the configuration, draft or edit code,
generate tests and documentation, debug, refactor, and review changes. Review
AI-generated changes and run relevant tests or checks when available before
committing. Apply extra scrutiny to security-sensitive changes.

Never provide AI tools with secrets, credentials, or private personal data.
Agents may make scoped edits and run relevant checks, but must ask before risky
or destructive actions. No special AI attribution is required; follow the
repository's usual commit and contribution conventions.

Do not use AI to automatically file or submit pull requests, issues, or other
public repository content. Do not publish irrelevant, inaccurate, nonsensical,
or otherwise low-quality AI-generated content. Any externally visible
contribution must be purposeful, checked by a human, and explicitly authorized
by the repository owner.
