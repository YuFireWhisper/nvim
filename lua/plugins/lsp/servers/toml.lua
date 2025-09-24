local lspconfig = require("lspconfig")
local common = require("plugins.lsp.common")

lspconfig.taplo.setup({
  capabilities = common.capabilities,
  on_attach = common.on_attach,
  settings = {
    taplo = {
      diagnostics = {
        enable = true,
      },
    },
  },
})
