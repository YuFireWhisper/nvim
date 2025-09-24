local lspconfig = require("lspconfig")
local common = require("plugins.lsp.common")

lspconfig.pyright.setup({
  capabilities = common.capabilities,
  on_attach = common.on_attach,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        typeCheckingMode = "basic",
        diagnosticMode = "workspace",
        autoImportCompletions = true,
        useLibraryCodeForTypes = true,
        diagnosticSeverityOverrides = {
          reportUnusedVariable = "warning",
          reportOptionalMemberAccess = "warning",
        },
      },
    },
  },
})
