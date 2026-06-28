require("mason").setup()

require("mason-tool-installer").setup({
  ensure_installed = {
    -- LSP servers
    "basedpyright",
    "bash-language-server",
    "biome",
    "clangd",
    "cmake-language-server",
    "css-lsp",
    "docker-compose-language-service",
    "docker-language-server",
    "dockerfile-language-server",
    "emmet-language-server",
    "lua_ls",
    "lua-language-server",
    "gopls",
    -- "haskell-language-server",
    "html-lsp",
    "htmx-lsp",
    "jinja-lsp",
    "json-lsp",
    "lemminx",
    "marksman",
    "powershell-editor-services",
    --"roslyn-language-server",
    "ruff",
    "rust-analyzer",
    "sqlls",
    "svelte-language-server",
    "tailwindcss-language-server",
    "taplo",
    "ty",
    "typescript-language-server",
    "yaml-language-server",
    "zls",

    -- Formatters
    "stylua",
    "prettier",
    "clang-format",
    "goimports",
    "yamlfmt",
    "xmlformatter",
  },

  auto_update = true,
  run_on_start = true,
})

require("mason-lspconfig").setup({
  automatic_enable = true,
})
