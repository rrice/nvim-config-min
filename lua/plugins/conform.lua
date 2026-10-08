local conform = require("conform")
local function tool(name)
	local candidates = {
		vim.fn.stdpath("data") .. "/mason/bin/" .. name,
		vim.fn.stdpath("data") .. "/mason/bin/" .. name .. ".exe",
		name,
	}

	for _, candidate in ipairs(candidates) do
		if vim.fn.executable(candidate) == 1 then
			return candidate
		end
	end

	return name
end

local function biome_args()
	local config_path = vim.fn.expand("~/.config/biome/biome.json")
	local args = { "format", "--stdin-file-path", "$FILENAME" }

	if vim.fn.filereadable(config_path) == 1 then
		table.insert(args, "--config-path")
		table.insert(args, config_path)
	end

	return args
end

conform.setup({
	formatters = {
		biome = {
			command = tool("biome"),
			args = biome_args,
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
			cmd = { tool("prettier"), "--stdin-filepath", "$FILENAME" },

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
		sh = { "shfmt" },
		rust = { "rustfmt" },
	},

	format_on_save = {
		timeout_ms = 1000,
		lsp_format = "fallback",
	},
})

-- Formatting
vim.keymap.set("n", "<leader>ff", function()
	conform.format({
		async = true,
		lsp_format = "fallback",
	})
end, {
	desc = "Format buffer",
})

vim.keymap.set("n", "<leader>fs", function()
	vim.lsp.buf.format({ async = true })
end, { desc = "Format via LSP" })
