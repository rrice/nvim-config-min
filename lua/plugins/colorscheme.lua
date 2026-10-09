-- Theme setup.
local tokyonight = require("tokyonight")

tokyonight.setup({
	style = "night",
	styles = {
		floats = "normal",
	},
})

vim.cmd.colorscheme("tokyonight-night")

vim.api.nvim_set_hl(0, "Pmenu", { link = "NormalFloat" })
vim.api.nvim_set_hl(0, "PmenuBorder", { link = "FloatBorder" })
