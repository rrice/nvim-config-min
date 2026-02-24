vim.pack.add({
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/folke/snacks.nvim" }
})

local snacks = require("snacks")

snacks.setup({
	bigfile = { enabled = true },
	dashboard = { enabled = true },
	explorer = { enabled = true },
	indent = { enabled = true },
	input = { enabled = true },
	notifier = {
	enabled = true,
			timeout = 3000,
		},
		picker = { enabled = true },
		quickfile = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
		styles = {
			notification = {
				-- wo = { wrap = true } -- Wrap notifications
			}
		}	
})

local whichkey = require("which-key")

whichkey.setup({
	preset = "helix",
	-- Setup a popup window
	show_warnings = false,
	win = {
		border = "rounded",
		title = true,
		title_pos = "center",
		padding = { 2, 2, 2, 2 },
		style = "minimal",
		wo = {
			winblend = 10, -- A value between 0 (opaque) - 100 (transparent)
		},
	},
	layout = {
		height = { min = 1, max = 10 }, -- Dynamically adjust the height.
		width = { min = 1, max = 50 }, -- Dynamically adjust the width.
		spacing = 3, -- Spacing between columns.
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
		{ "<leader>q", group = "quit/session" },
		{ "<leader>s", group = "search" },
		{ "<leader>u", group = "ui" },
		{ "<leader>x", group = "diagnostics/quickfix" },
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

	triggers = {
		{ "<leader>", mode = { "n", "v" }},
		{ "<auto>", mode = "nixsotc" },
		{ "a", mode = { "n", "v" }},
	}
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

-- Diagnostics
local diagnostic_goto = function(next, severity)
  return function()
    vim.diagnostic.jump({
      count = (next and 1 or -1) * vim.v.count1,
      severity = severity and vim.diagnostic.severity[severity] or nil,
      float = true,
    })
  end
end

keymap("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
keymap("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
keymap("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
keymap("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
keymap("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
keymap("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
keymap("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- Simplified window navigation.
keymap({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
keymap({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
keymap({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
keymap({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
keymap("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
keymap("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
keymap("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
keymap("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize window using <ctrl> arrow keys
keymap("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
keymap("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
keymap("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
keymap("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Move Lines
keymap("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
keymap("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
keymap("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
keymap("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
keymap("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
keymap("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- Buffer Management
keymap("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
keymap("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
keymap("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
keymap("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
keymap("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
keymap("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
keymap("n", "<leader>bd", function()
	Snacks.bufdelete()
end, { desc = "Delete Buffer" })
keymap("n", "<leader>bo", function()
	Snacks.bufdelete.other()
end, { desc = "Delete Other Buffers" })
keymap("n", "<leader>bD", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })


