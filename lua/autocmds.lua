-- Add any additional autocmds here

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local highlight_group = augroup("YankHighlight", { clear = true })

autocmd('TextYankPost', {
	pattern = '*',
	callback = function()
		vim.highlight.on_yank({ timeout = 150 })
	end,
	group = highlight_group
})

autocmd({ "FileType" }, {
	pattern = { "markdown" },
	callback = function()
		vim.g.markdown_folding = 1
	end,
})
