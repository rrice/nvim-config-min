-- Add any additional autocmds here

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local highlight_group = augroup("YankHighlight", { clear = true })

autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ timeout = 150 })
	end,
	group = highlight_group,
})

-- File Type autoconfig.
autocmd({ "FileType" }, {
	pattern = { "markdown" },
	callback = function()
		vim.g.markdown_folding = 1
	end,
})

-- File Type overrides.
autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*.tmpl", "*.tpl" },
	callback = function()
		vim.bo.filetype = "gotmpl"
	end,
})

-- LSP completion
autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, args.data.client_id, args.buf, {
				autotrigger = true,
			})
		end
	end,
})
