local lspconfig = require("lspconfig")
local common = require("plugins.lsp.common")

-- HTML
lspconfig.html.setup({
  capabilities = common.capabilities,
  on_attach = common.on_attach,
})

-- CSS
lspconfig.cssls.setup({
  capabilities = common.capabilities,
  on_attach = common.on_attach,
})

-- Emmet
lspconfig.emmet_ls.setup({
  capabilities = common.capabilities,
  on_attach = common.on_attach,
  filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
})

-- Tailwind CSS
lspconfig.tailwindcss.setup({
  capabilities = common.capabilities,
  on_attach = common.on_attach,
})
