local lspconfig = require("lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()
if pcall(require, "cmp_nvim_lsp") then
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
end

local function get_python_path()
  local venv = os.getenv("VIRTUAL_ENV")
  if venv then
    return venv .. "/bin/python"
  else
    return vim.fn.exepath("python3") or vim.fn.exepath("python")
  end
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
              return action.kind and (
                action.kind == "quickfix" or
                action.kind == "source.fixAll" or
                action.kind == "source.fixAll.clang-tidy" or
                action.kind == "source.fixAll.python" or
                action.kind == "source.fixAll.ruff" or
                action.kind == "source.organizeImports"
              )
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
        suggest = {
          includeCompletionsForModuleExports = true,
        },
        implementationsCodeLens = true,
        referencesCodeLens = true,
      },
    },
  },
  pyright = {
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "basic",
          pythonPath = get_python_path(),
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
  clangd = {
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--header-insertion=iwyu",
      "--completion-style=detailed",
      "--function-arg-placeholders",
      "--fallback-style=llvm",
    },
  },
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy",
        },
      },
    },
  },
  taplo = {
    settings = {
      taplo = {
        diagnostics = {
          enable = true,
        },
      },
    },
  },
}

vim.diagnostic.config({
  virtual_text = {
    prefix = '~',
    format = function(diagnostic)
      return diagnostic.message
    end,
  },
  float = {
    border = "rounded",
    source = "always",
  },
  severity_sort = true,
})

for server_name, server_config in pairs(servers) do
  server_config.capabilities = capabilities
  server_config.on_attach = on_attach
  lspconfig[server_name].setup(server_config)
end

for _, server_name in ipairs({ "cssls", "html", "jsonls", "lua_ls", "tailwindcss" }) do
  lspconfig[server_name].setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })
end
