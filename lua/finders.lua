local ts_themes = require("telescope.themes")
local ts_builtin = require("telescope.builtin")

local ts = require("telescope")

ts.setup({
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sort = true,
			case_mode = "smart_case",
		},
		["ui-select"] = {
			ts_themes.get_dropdown({}),
		},
	},
})
--ts.load_extension("fzf")
ts.load_extension("ui-select")

-- Telescope keymaps

local keymap = vim.keymap.set
keymap("n", "<leader>sh", ts_builtin.help_tags, { desc = "[S]earch [H]elp" })
keymap("n", "<leader>sk", ts_builtin.keymaps, { desc = "[S]earch [K]eymaps" })
keymap("n", "<leader>sf", ts_builtin.find_files, { desc = "[S]earch [F]iles" })
keymap("n", "<leader>ss", ts_builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
keymap("n", "<leader>sw", ts_builtin.grep_string, { desc = "[S]earch current [W]ord" })
keymap("n", "<leader>sg", ts_builtin.live_grep, { desc = "[S]earch by [G]rep" })
keymap("n", "<leader>sd", ts_builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
keymap("n", "<leader>sr", ts_builtin.resume, { desc = "[S]earch [R]esume" })
keymap("n", "<leader>s.", ts_builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
keymap("n", "<leader><leader>", ts_builtin.buffers, { desc = "[ ] Find existing buffers" })
keymap("n", "<leader>sn", function()
	ts_builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[S]earch [N]eovim configuration" })

-- Neogit
local neogit = require("neogit")
neogit.setup({
	graph_style = "unicode",
})
