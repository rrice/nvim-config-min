-- lua/lsp.lua

require("mason").setup()

require("mason-tool-installer").setup({
	ensure_installed = {
		-- LSP servers
		"lua_ls",
		"lua-language-server",
		"gopls",
		"rust-analyzer",
		"typescript-language-server",
		"zls",
		"basedpyright",
		"ruff",

		-- Formatters
		"stylua",
		"prettier",
		"clang-format",
		"goimports",
		"yamlfmt",
		"xmlformatter",
	},

	auto_update = false,
	run_on_start = true,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()

local ok, blink = pcall(require, "blink.cmp")
if ok then
	capabilities = blink.get_lsp_capabilities(capabilities)
end

vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	underline = true,
	severity_sort = true,
	update_in_insert = false,

	float = {
		border = "rounded",
		source = "if_many",
	},
})

local on_attach = function(_, bufnr)
	local opts = { buffer = bufnr }

	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

	vim.keymap.set("n", "<leader>uh", function()
		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
	end, opts)
end

local servers = {
	lua_ls = require("lsp.lua_ls"),
	gopls = {},

	basedpyright = {},

	rust_analyzer = {},

	ts_ls = {},

	zls = {},
}

for server, config in pairs(servers) do
	config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})

	config.on_attach = on_attach

	vim.lsp.config(server, config)
	vim.lsp.enable(server)
end
