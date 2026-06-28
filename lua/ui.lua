-- Theme setup.
require("tokyonight").setup({
  style = "night",
})

-- Lualine setup.
require("lualine").setup({
  options = {
    theme = "tokyonight",
  },
})

-- nvim-tree setup
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
