local lspconfig = require("lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()
if pcall(require, "cmp_nvim_lsp") then
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
end

local on_attach = function(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)

  if client.server_capabilities.documentFormattingProvider then
    local format_group = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = format_group,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end
end

local servers = {
  ts_ls = {
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
      },
    },
  },
  pyright = {
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "basic",
        },
      },
    },
  },
  eslint = {
    settings = {
      workingDirectory = { mode = "location" },
      onIgnoredFiles = "off",
    },
    root_dir = function(fname)
      return lspconfig.util.find_git_ancestor(fname) or vim.fn.getcwd()
    end,
  },
  emmet_ls = {
    filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
  },
}

vim.diagnostic.config({
  float = {
    border = "rounded",
    source = "always",
  },
})

for server_name, server_config in pairs(servers) do
  server_config.capabilities = capabilities
  server_config.on_attach = on_attach
  lspconfig[server_name].setup(server_config)
end

for _, server_name in ipairs({ "clangd", "cssls", "html", "tailwindcss", "jsonls", "lua_ls" }) do
  lspconfig[server_name].setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })
end
