local ts_builtin = require("telescope.builtin")
local ts = require("telescope")

ts.setup({
	defaults = {
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"--hidden",
			"--glob=!**/.git/*",
		},
	},
	pickers = {
		find_files = {
			hidden = true,
		},
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sort = true,
			override_file_sort = true,
			case_mode = "smart_case",
		},
	},
})

ts.load_extension("fzf")

-- Telescope keymaps

vim.keymap.set("n", "<leader>sh", ts_builtin.help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sk", ts_builtin.keymaps, { desc = "[S]earch [K]eymaps" })
vim.keymap.set("n", "<leader>sf", ts_builtin.find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>ss", ts_builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
vim.keymap.set("n", "<leader>sw", ts_builtin.grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", ts_builtin.live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", ts_builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sr", ts_builtin.resume, { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>s.", ts_builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set("n", "<leader><leader>", ts_builtin.buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>sn", function()
	ts_builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[S]earch [N]eovim configuration" })
