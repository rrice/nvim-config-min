-- Run build/update hooks before vim.pack.add().
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(event)
		local name = event.data.spec.name
		local kind = event.data.kind
		local path = event.data.path

		if name == "telescope-fzf-native.nvim" and (kind == "install" or kind == "update") then
			vim.system({ "make" }, {
				cwd = path,
				text = true,
			}):wait()
		end

		if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
			vim.schedule(function()
				if vim.fn.exists(":TSUpdate") == 2 then
					vim.cmd("TSUpdate")
				end
			end)
		end
	end,
})

vim.pack.add({
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/folke/tokyonight.nvim" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/sindrets/diffview.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
	{ src = "https://github.com/NeogitOrg/neogit" },
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		version = "main",
	},
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/hrsh7th/nvim-cmp" },
	{ src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
	{ src = "https://github.com/hrsh7th/cmp-buffer" },
	{ src = "https://github.com/hrsh7th/cmp-path" },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/saadparwaiz1/cmp_luasnip" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-tree.lua" },
	{ src = "https://github.com/github/copilot.vim" },
})

require("plugins.colorscheme")
require("plugins.nvim-treesitter")
require("plugins.which-key")
require("plugins.telescope")
require("plugins.lualine")
require("plugins.nvim-tree")
require("plugins.conform")
require("plugins.cmp")
require("plugins.mason")
require("plugins.neogit")
require("plugins.diffview")
