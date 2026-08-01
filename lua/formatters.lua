local t = require("conform")

local mason_root = vim.fn.stdpath("data") .. "/mason/packages"
local biome_path = mason_root .. "/biome/node_modules/.bin/biome"
local prettier_path = mason_root .. "/prettier/node_modules/.bin/prettier"

t.setup({
  formatters = {
    biome = {
      command = biome_path,
      args = {
        "format",
        "--stdin-file-path",
        "$FILENAME",
        "--config-path",
        vim.fn.expand("~/.config/biome/biome.json"),
      },
      stdin = true,
      filetypes = {
        "javascript",
        "jsx",
        "typescript",
        "tsx",
        "json",
        "jsonc",
        "css",
        "scss",
        "html",
        "markdown",
      },
    },
    prettier = {
      cmd = { prettier_path, "--stdin-filepath", "$FILENAME" },

      --If you need extra plugins (e.g. tailwindcss, astro) you can add them here:
      -- args = function(_, ctx)
      --   local extra = {}
      --   if ctx.filename:match("%.astro$") then
      --     table.insert(extra, "--plugin")
      --     table.insert(extra, "prettier-plugin-astro")
      --   end
      --   table.insert(extra, "--plugin")
      --   table.insert(extra, "prettier-plugin-tailwindcss")
      --   return extra
      -- end,
    },
  },
  formatters_by_ft = {
    javascript = { "biome" },
    javascriptreact = { "biome" },
    typescript = { "biome" },
    typescriptreact = { "biome" },
    json = { "biome", "prettier", stop_after_first = true },
    lua = { "stylua" },
    c = { "clang-format" },
    go = { "goimports", "gofmt", stop_after_first = true },
    html = { "prettier" },
    markdown = { "prettier" },
    css = { "prettier" },
    xml = { "xmlformatter" },
    yaml = { "yamlfmt" },
    python = { "ruff_fix", "ruff_format" },
    rust = { "rustfmt" },
  },
  -- Setup automatic format-on-save.
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "never",
  },
})
