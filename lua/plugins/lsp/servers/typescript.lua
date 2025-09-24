vim.lsp.config('ts_ls', {
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
      },
      suggest = {
        includeCompletionsForModuleExports = true,
      },
      implementationsCodeLens = true,
      referencesCodeLens = true,
    },
  },
});

vim.lsp.config('eslint', {
  settings = {
    workingDirectory = { mode = "location" },
    onIgnoredFiles = "off",
  },
})
