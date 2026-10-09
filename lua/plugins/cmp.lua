local cmp = require("cmp")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("*", {
	capabilities = capabilities,
})

cmp.setup({
	preselect = cmp.PreselectMode.Item,
	snippet = {
		expand = function(args)
			vim.snippet.expand(args.body)
		end,
	},
	window = {
		completion = {
			border = "rounded",
			winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
			winblend = 0,
		},
		documentation = {
			border = "rounded",
			winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:NormalFloat,Search:None",
			winblend = 0,
		},
	},
	view = {
		docs = {
			auto_open = true,
		},
	},
	mapping = cmp.mapping({
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<CR>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.confirm({ select = true })
			else
				fallback()
			end
		end, { "i", "s" }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.confirm({ select = true })
			else
				fallback()
			end
		end, { "i", "s" }),
		["<Up>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
			else
				vim.api.nvim_feedkeys(
					vim.api.nvim_replace_termcodes("<C-d>", true, false, true),
					"n",
					false
				)
			end
		end, { "i", "s" }),
		["<Down>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
	}, {
		{ name = "buffer" },
	}),
})
