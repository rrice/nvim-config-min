local t = require("conform")

local biome_path = vim.fn.stdpath("data") .. "/mason/packages/biome/node_modules/.bin/biome"

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
		python = { "isort", "autopep8" },
		rust = { "rustfmt", lsp_format = "fallback" },
	},
	-- Setup automatic format-on-save.
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "never",
	},
})
