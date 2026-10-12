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

conform.setup({
	formatters = {
		biome = {
			command = tool("biome"),
			args = { "format", "--stdin-file-path", "$FILENAME" },
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
		prettier_svelte = {
			command = tool("prettier"),
			args = { "--plugin", "prettier-plugin-svelte", "--stdin-filepath", "$FILENAME" },
			stdin = true,
		},
		zigfmt = {
			command = tool("zig"),
			args = { "fmt", "--stdin" },
			stdin = true,
		},
	},
	formatters_by_ft = {
		javascript = { "biome" },
		javascriptreact = { "biome" },
		typescript = { "biome" },
		typescriptreact = { "biome" },
		json = { "biome", "prettier", stop_after_first = true },
		jsonc = { "biome" },
		lua = { "stylua" },
		c = { "clang-format" },
		cpp = { "clang-format" },
		go = { "goimports", "gofmt", stop_after_first = true },
		html = { "prettier" },
		markdown = { "prettier" },
		css = { "prettier" },
		scss = { "prettier" },
		less = { "prettier" },
		xml = { "xmlformatter" },
		yaml = { "yamlfmt" },
		python = { "ruff_fix", "ruff_format" },
		sh = { "shfmt" },
		rust = { "rustfmt" },
		toml = { "taplo" },
		sql = { "sqlfluff" },
		svelte = { "prettier_svelte" },
		cmake = { "cmake_format" },
		zig = { "zigfmt" },
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
