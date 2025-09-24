vim.lsp.config('pyright', {
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
