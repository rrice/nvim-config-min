-- Add any additional autocmds here


local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ timeout = 150 })
	end,
	group = highlight_group,
})

-- File Type autoconfig.
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "markdown" },
	callback = function()
		vim.g.markdown_folding = 1
	end,
})

-- File Type overrides.
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*.tmpl", "*.tpl" },
	callback = function()
		vim.bo.filetype = "gotmpl"
	end,
})

-- Autocreate directory when saving file
-- When saving a path like src/test/test.js when the folders do not exist,
-- this will create those directories automatically instead of producing an error.
vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function(event)
		local file = vim.uv.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})


