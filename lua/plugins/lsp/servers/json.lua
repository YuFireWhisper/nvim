local lspconfig = require("lspconfig")
local common = require("plugins.lsp.common")

lspconfig.jsonls.setup({
  capabilities = common.capabilities,
  on_attach = common.on_attach,
})
