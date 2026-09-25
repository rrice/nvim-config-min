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
		"docker-language-server",
		"emmet-language-server",
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

vim.lsp.enable({
	"basedpyright",
	"bashls",
	"biome",
	"clangd",
	"cmake",
	"cssls",
	"docker_language_server",
	"emmet_language_server",
	"lua_ls",
	"gopls",
	"html",
	"htmx",
	"jinja_lsp",
	"jsonls",
	"lemminx",
	"marksman",
	"powershell_es",
	"ruff",
	"rust_analyzer",
	"sqlls",
	"svelte",
	"tailwindcss",
	"taplo",
	"ts_ls",
	"yamlls",
	"zls",
})

-- LSP completion
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, args.data.client_id, args.buf, {
				autotrigger = true,
			})
		end
	end,
})
