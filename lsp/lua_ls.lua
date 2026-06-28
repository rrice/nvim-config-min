return {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT', -- Neovim uses LuaJIT
      },
      diagnostics = {
        globals = { 'vim' }, -- Declare 'vim' as a global variable
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true), -- Include Neovim's runtime files
        checkThirdParty = false,
      },
      telemetry = {
        enable = false, -- Optional: Disable telemetry
      },
    },
  },
}

