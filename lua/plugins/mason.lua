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
		"rustfmt",
		"shfmt",
		"yamlfmt",
		"xmlformatter",
	},

	-- Keep startup predictable; install tools explicitly with :Mason or :MasonToolsInstall.
	auto_update = false,
	run_on_start = false,
})

vim.lsp.enable({
	"basedpyright",
	"bashls",
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

vim.api.nvim_create_autocmd("InsertCharPre", {
	callback = function(args)
		local char = vim.v.char
		if char == "" then
			return
		end

		for _, client in ipairs(vim.lsp.get_clients({ bufnr = args.buf })) do
			local provider = client.server_capabilities.signatureHelpProvider
			if provider and client:supports_method("textDocument/signatureHelp", args.buf) then
				local trigger_chars = vim.list_extend(
					vim.deepcopy(provider.triggerCharacters or {}),
					provider.retriggerCharacters or {}
				)
				if vim.list_contains(trigger_chars, char) then
					vim.schedule(function()
						local mode = vim.api.nvim_get_mode().mode
						if vim.api.nvim_buf_is_valid(args.buf)
							and vim.api.nvim_get_current_buf() == args.buf
							and mode:sub(1, 1) == "i"
						then
							vim.lsp.buf.signature_help()
						end
					end)
					return
				end
			end
		end
	end,
})

-- LSP completion
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client then
			return
		end

		local lsp_keymaps = {
			{ "textDocument/declaration", "gD", vim.lsp.buf.declaration, "Go to declaration" },
			{ "textDocument/definition", "gd", vim.lsp.buf.definition, "Go to definition" },
			{ "textDocument/implementation", "gI", vim.lsp.buf.implementation, "Go to implementation" },
			{ "textDocument/references", "gr", vim.lsp.buf.references, "Go to references" },
			{ "textDocument/typeDefinition", "gy", vim.lsp.buf.type_definition, "Go to type definition" },
			{ "textDocument/hover", "K", vim.lsp.buf.hover, "Hover documentation" },
			{ "textDocument/rename", "<leader>cr", vim.lsp.buf.rename, "Rename symbol" },
			{ "textDocument/codeAction", "<leader>ca", vim.lsp.buf.code_action, "Code action" },
		}

		for _, keymap in ipairs(lsp_keymaps) do
			local method, lhs, rhs, desc = unpack(keymap)
			if client:supports_method(method, args.buf) then
				vim.keymap.set("n", lhs, rhs, { buffer = args.buf, desc = desc })
			end
		end

		if client:supports_method("textDocument/codeAction", args.buf) then
			vim.keymap.set("v", "<leader>ca", vim.lsp.buf.code_action, {
				buffer = args.buf,
				desc = "Code action",
			})
		end

	end,
})
