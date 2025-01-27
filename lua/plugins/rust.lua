return {
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local rt = require("rust-tools")
      rt.setup({
        server = {
          on_attach = function(client, bufnr)
            local bufopts = { noremap = true, silent = true, buffer = bufnr }
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
            vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
            vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)

            vim.keymap.set("n", "<leader>rh", rt.hover_actions.hover_actions, bufopts)
            vim.keymap.set("n", "<leader>ra", rt.code_action_group.code_action_group, bufopts)
            vim.keymap.set("n", "<leader>re", rt.expand_macro.expand_macro, bufopts)
            vim.keymap.set("n", "<leader>rr", rt.runnables.runnables, bufopts)
            vim.keymap.set("n", "<F5>", "<cmd>RustRun<CR>", bufopts)
            vim.keymap.set("n", "<leader>rd", rt.debuggables.debuggables, bufopts)

            if client.server_capabilities.documentFormattingProvider then
              local format_group = vim.api.nvim_create_augroup("RustFormatting", { clear = true })
              vim.api.nvim_create_autocmd("BufWritePre", {
                group = format_group,
                buffer = bufnr,
                callback = function()
                  vim.lsp.buf.format({ async = false })
                end,
              })
            end
          end,
          settings = {
            ["rust-analyzer"] = {
              checkOnSave = {
                command = "clippy",
              },
              cargo = {
                allFeatures = true,
              },
              procMacro = {
                enable = true,
              },
              diagnostics = {
                enable = true,
                experimental = {
                  enable = true,
                },
              },
              check = {
                command = "check",
                extraArgs = "--all-features",
              },
            },
          },
        },
        tools = {
          inlay_hints = {
            auto = true,
            show_parameter_hints = true,
          },
          hover_actions = {
            auto_focus = true,
          },
        },
      })
    end,
  },
  {
    "saecki/crates.nvim",
    ft = { "rust", "toml" },
    config = function()
      require("crates").setup({
        null_ls = {
          enabled = true,
          name = "crates.nvim",
        },
        popup = {
          border = "rounded",
        },
      })
    end,
  },
}
