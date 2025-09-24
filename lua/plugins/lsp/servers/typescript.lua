local lspconfig = require("lspconfig")
local common = require("plugins.lsp.common")

lspconfig.ts_ls.setup({
  capabilities = common.capabilities,
  on_attach = common.on_attach,
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
})

lspconfig.eslint.setup({
  capabilities = common.capabilities,
  on_attach = common.on_attach,
  settings = {
    workingDirectory = { mode = "location" },
    onIgnoredFiles = "off",
  },
  root_dir = function(fname)
    return lspconfig.util.find_git_ancestor(fname) or vim.fn.getcwd()
  end,
})
