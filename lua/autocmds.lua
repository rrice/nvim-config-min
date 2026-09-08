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

-- Autocreate directory when saving file
-- When saving a path like src/test/test.js when the folders do not exist,
-- this will create those directories automatically instead of producing an error.
autocmd("BufWritePre", {
	callback = function(event)
		local file = vim.uv.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
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
