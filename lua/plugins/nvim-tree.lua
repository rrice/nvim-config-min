-- nvim-tree setup
require("nvim-tree").setup({
	sort = {
		sorter = "case_sensitive",
	},
	view = {
		width = 30,
	},
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = true,
	},
})

vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
	callback = function()
		local isNotNvimTree = (vim.bo.filetype ~= "NvimTree")
		vim.wo.number = isNotNvimTree
		vim.wo.relativenumber = isNotNvimTree
	end,
})
