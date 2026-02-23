
vim.pack.add{
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
}

require("mason").setup()
require("mason-lspconfig").setup()

require("mason-tool-installer").setup({
	-- These are just the lsps I use. You can specify your own.
	ensure_installed = {
		"lua_ls",
		"bashls",
		"cmake",
		"docker_language_server",
		"emmet_language_server",
		"gopls",
		"hls",
		"html",
		"htmx",
		"jinja_lsp",
		"powershell_es",
		"rust_analyzer",
		"svelte",
		"ts_ls",
		"ty",
		"yamlls",
		"zls",
	}
})


