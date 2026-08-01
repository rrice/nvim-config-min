local cmp = require("cmp")

return {
  mapping = cmp.mapping.preset.insert({
    ["<UP>"] = cmp.mapping.select_prev_item(),
    ["<DOWN"] = cmp.mapping.select_next_item(),
    ["<TAB>"] = cmp.mapping.complete(),
    ["<ENTER"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
  }, {
    { name = "buffer" },
    { name = "path" },
  }),
}
