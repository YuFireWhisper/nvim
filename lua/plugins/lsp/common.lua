local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()
if pcall(require, "cmp_nvim_lsp") then
  M.capabilities = require("cmp_nvim_lsp").default_capabilities(M.capabilities)
end

M.on_attach = function(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)

  if client.name == "tsserver" then
    vim.keymap.set('n', '<leader>ti', '<cmd>TypescriptAddMissingImports<CR>', bufopts)
    vim.keymap.set('n', '<leader>to', '<cmd>TypescriptOrganizeImports<CR>', bufopts)
    vim.keymap.set('n', '<leader>tr', '<cmd>TypescriptRenameFile<CR>', bufopts)
  end

  if client.server_capabilities.codeActionProvider then
    local code_action_group = vim.api.nvim_create_augroup("LspCodeAction", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = code_action_group,
      buffer = bufnr,
      callback = function()
        local diagnostics = vim.diagnostic.get(0)
        if #diagnostics > 0 then
          vim.lsp.buf.code_action({
            filter = function(action)
              if not action.kind then
                return false
              end
              return action.kind == "quickfix" or
                  action.kind == "source.fixAll" or
                  action.kind == "source.fixAll.clang-tidy" or
                  action.kind == "source.fixAll.python" or
                  action.kind == "source.fixAll.ruff" or
                  action.kind == "source.organizeImports"
            end,
            apply = true,
          })
        end
      end,
    })
  end

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

M.setup_diagnostics = function()
  vim.diagnostic.config({
    virtual_text = {
      prefix = '~',
      format = function(diagnostic)
        return diagnostic.message
      end,
    },
    float = {
      border = "rounded",
      source = true,
    },
    severity_sort = true,
  })
end

return M
