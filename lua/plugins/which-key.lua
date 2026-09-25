require("which-key").setup({
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
		{ "<leader>c", group = "code" },
		{ "<leader>f", group = "file/find" },
		{ "<leader>s", group = "search" },
		{ "<leader>ff", desc = "Format buffer" },
		{ "<leader>fs", desc = "Format via LSP" },
		{ "[", group = "prev" },
		{ "]", group = "next" },
		{ "g", group = "goto" },
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
		{ "<leader>", mode = { "n", "v" } },
		{ "<auto>", mode = "nxso" },
	},
})
