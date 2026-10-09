vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.copilot_no_tab_map = true
vim.diagnostic.config({
	virtual_text = true,
})

require("vim._core.ui2").enable()
require("plugins")
require("configs")
