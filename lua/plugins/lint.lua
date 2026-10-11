local lint = require("lint")

lint.linters_by_ft = {
	sh = { "shellcheck" },
	go = { "golangcilint" },
	dockerfile = { "hadolint" },
	css = { "stylelint" },
	scss = { "stylelint" },
	less = { "stylelint" },
	yaml = { "yamllint" },
	markdown = { "markdownlint-cli2" },
	sql = { "sqlfluff" },
	lua = { "luacheck" },
}

lint.linters.luacheck.args = {
	"--formatter",
	"plain",
	"--codes",
	"--ranges",
	"--globals",
	"vim",
	"-",
}

vim.api.nvim_create_autocmd("BufWritePost", {
	callback = function()
		lint.try_lint()
	end,
})

vim.keymap.set("n", "<leader>ll", function()
	lint.try_lint()
end, { desc = "Lint current buffer" })
