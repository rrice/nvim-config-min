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
		{ "<leader>ff", desc = "Format buffer" },
		{ "<leader>fs", desc = "Format via LSP fallback" },
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
		{ "<leader>", mode = { "n", "v" } },
		{ "<auto>", mode = "nixsotc" },
		{ "a", mode = { "n", "v" } },
	},
})


