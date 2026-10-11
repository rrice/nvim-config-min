# nvim-config-min Repository

## Overview

Personal Neovim 0.12+ configuration using built-in `vim.pack` plugin management and native LSP APIs. No external plugin manager (Lazy) required.

## Repository Structure

- **init.lua**: Entry point. Enables experimental UI2, loads plugins and configs.
- **lua/plugins/init.lua**: Core plugin list via `vim.pack.add()` with build hooks for Telescope and Treesitter.
- **lua/plugins/**: Individual plugin configs (cmp, mason, conform, nvim-tree, telescope, which-key, colorscheme, neogit, diffview, lualine, nvim-treesitter).
- **lua/configs/**: Editor configuration (options, keymaps, autocmds).
- **lua/utils/buffer.lua**: Buffer deletion utilities.
- **lsp/**: LSP server configuration (lua_ls, emmet_language_server).

## Key Technologies

- **Completion**: nvim-cmp + LuaSnip + LSP + paths + buffer words + Friendly Snippets
- **LSP**: Native Neovim LSP + Mason + mason-tool-installer (29 LSP servers configured)
- **Formatting**: Conform.nvim with Biome, Prettier, Stylua, Clang-format, and per-language rules
- **Treesitter**: 27 language parsers configured, auto-enabled per filetype
- **UI**: Tokyonight theme, lualine statusline, nvim-tree file explorer, which-key keybinding help
- **Git**: Neogit + Diffview
- **Search/Navigation**: Telescope with FZF native extension
- **Copilot**: copilot.vim integrated

## First-Time Setup

1. Run `:MasonToolsInstall` to install language servers and formatters
2. Run `:TSInstallConfigured` to install Treesitter parsers

## Notable Config Details

- Uses tabs instead of spaces by default (configurable per filetype)
- Experimental UI2 interface enabled
- Auto-format on save with 1s timeout
- Soft tabstop aligned with shiftwidth
- Persistent undo enabled
- Clipboard synced (SSH detection included)
- Dynamic window borders (rounded)
- Comprehensive diagnostic keybindings and LSP integration

## AI Usage Policy

AI tools may be used to understand the repository, draft or edit code, generate
tests and documentation, debug, refactor, and review changes.

- Review AI-generated changes and run relevant tests or checks when available
  before committing.
- Apply extra scrutiny to security-sensitive changes.
- Never provide AI tools with secrets, credentials, or private personal data.
- Make scoped edits and run relevant checks autonomously; ask before risky or
  destructive actions.
- No special AI attribution is required. Follow the repository's usual commit
  and contribution conventions.
- Do not automatically file or submit pull requests, issues, or other public
  repository content with AI. Do not publish irrelevant, inaccurate,
  nonsensical, or otherwise low-quality AI-generated content. Any externally
  visible contribution must be purposeful, human-checked, and explicitly
  authorized by the repository owner.

## License

MIT (Copyright 2024 Ralph Allan Rice)
