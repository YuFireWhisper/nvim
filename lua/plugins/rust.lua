return {
  {
    'mrcjkb/rustaceanvim',
    version = '^6',
    lazy = false,
    opts = {
      server = {
        on_attach = function(client, bufnr)
          local bufopts = { noremap = true, silent = true, buffer = bufnr }
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, vim.tbl_extend("force", bufopts, { desc = "跳轉到定義" }))
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, vim.tbl_extend("force", bufopts, { desc = "顯示懸浮資訊" }))
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, vim.tbl_extend("force", bufopts, { desc = "跳轉到實現" }))
          vim.keymap.set('n', '<leader>fm', vim.lsp.buf.format, vim.tbl_extend("force", bufopts, { desc = "格式化" }))
          vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, vim.tbl_extend("force", bufopts, { desc = "重命名" }))
          vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, vim.tbl_extend("force", bufopts, { desc = "代碼操作" }))
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, vim.tbl_extend("force", bufopts, { desc = "查找引用" }))

          vim.keymap.set("n", "<leader>rt", "<cmd>RustTest<CR>",
            vim.tbl_extend("force", bufopts, { desc = "運行 Rust 測試" }))
          vim.keymap.set("n", "<leader>ra", "<cmd>RustTest!<CR>",
            vim.tbl_extend("force", bufopts, { desc = "運行所有 Rust 測試" }))

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
            check = {
              command = "clippy",
            },
            cargo = {
              features = "all",
            },
            diagnostics = {
              disabled = { "macro-error", "inactive-code" },
            },
            imports = {
              granularity = {
                enforce = true,
              },
              prefix = "crate",
            },
          },
        },
        tools = {
          hover_actions = { auto_focus = true },
        },
      },
    },
    config = function(_, opts)
      vim.g.rustaceanvim = opts
    end,
  },
  {
    "saecki/crates.nvim",
    ft = { "rust", "toml" },
    opts = {
      popup = { border = "rounded" },
    },
  },
}
