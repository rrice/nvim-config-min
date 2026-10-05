vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.diagnostic.config({
	virtual_text = true,
})

require("vim._core.ui2").enable()
require("plugins")
require("configs")
