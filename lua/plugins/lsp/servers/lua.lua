local lspconfig = require("lspconfig")
local common = require("plugins.lsp.common")

lspconfig.lua_ls.setup({
  capabilities = common.capabilities,
  on_attach = common.on_attach,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
})
