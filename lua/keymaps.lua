vim.pack.add({
	{ src = "https://github.com/folke/which-key.nvim" }
})

vim.g.mapleader = ' '

local whichkey = require("which-key")

whichkey.setup({
	preset = "helix",
	-- Setup a popup window
	show_warnings = false,
	window = {
		border = "rounded",
		position = "bottom", 
		margin = { 1, 2, 1, 2 },
		padding = { 2, 2, 2, 2 },
		winblend = 10,
		style = "minimal",
	},
	spec = {
		mode = { "n", "x" },
		{ "<leader><tab>", group = "tabs" },
		{ "<leader>c", group = "code" },
		{ "<leader>d", group = "debug" },
		{ "<leader>dp", group = "profiler" },
		{ "<leader>f", group = "file/find" },
		{ "<leader>g", group = "git" },
		{ "<leader>gh", group = "hunks" },
		{ "<leader>s", group = "search" },
		{ "<leader>u", group = "ui" },
		{ "<leader>q", group = "diagnostics/quickfix" },
		{ "[", group = "prev" },
		{ "]", group = "next" },
		{ "g", group = "goto" },
		{ "gs", group = "surround" },
		{ "z", group = "fold" },
		{
			"<leader>b",
			group = "buffer",
			expand = function()
				return require("which-key.extras").expand.buf()
			end,
		},
		{
			"<leader>w",
			group = "windows",
			proxy = "<c-w>",
			expand = function()
				return require("which-key.extras").expand.win()
			end,
		},
		-- better descriptions
		{ "gx", desc = "Open with system app" },
	},
	layout = {
		height = { min = 1, max = 10 }, -- Dynamically adjust the height.
		width = { min = 1, max = 50 }, -- Dynamically adjust the width.
		spacing = 3, -- Spacing between columns.
	},
})

local keymap = vim.keymap.set
local s = { silent = true }

-- Set highlight on search, press <Esc> to clear.
vim.opt.hlsearch = true

-- Diagnostic keymap bindings.
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  float = {
    border = "single",
    format = function(d)
      return string.format("%s (%s) [%s]",
        d.message,
        d.source,
        d.code or d.user_data.lsp.code)
    end,
  },
})

keymap("n", "<Esc>", "<cmd>nohlsearch<CR>")


keymap("n", "[d", vim.diagnostic.get_prev, { desc = "Go to previous [D]iagnostic message" })
keymap("n", "]d", vim.diagnostic.get_next, { desc = "Go to next [D]iagnostic message" })
keymap("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
keymap("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uick fix list" })

-- Simplified window navigation.
keymap("n", "<C-D-Left>", "<C-w><C-h>", { desc = "Move focus to left window" })
keymap("n", "<C-D-Right>", "<C-w><C-l>", { desc = "Move focus to right window" })
keymap("n", "<C-D-Down>", "<C-w><C-j>", { desc = "Move focus to lower window" })
keymap("n", "<C-D-Up>", "<C-w><C-k>", { desc = "Move focus to upper window" })
