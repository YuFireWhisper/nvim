local lspconfig = require("lspconfig")
local common = require("plugins.lsp.common")

lspconfig.clangd.setup({
  capabilities = common.capabilities,
  on_attach = common.on_attach,
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--function-arg-placeholders",
    "--fallback-style=llvm",
  },
})
