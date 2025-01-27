return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      {
        "<leader>fm",
        function()
          local diagnostics = vim.diagnostic.get(0)

          if #diagnostics > 0 then
            for _, diagnostic in ipairs(diagnostics) do
              vim.api.nvim_win_set_cursor(0, { diagnostic.lnum + 1, diagnostic.col })

              vim.lsp.buf.code_action({
                filter = function(action)
                  return action.kind and (
                    action.kind == "quickfix" or
                    action.kind == "source.fixAll" or
                    action.kind == "source.fixAll.python" or
                    action.kind == "source.fixAll.ruff" or
                    action.kind == "source.organizeImports" or
                    action.kind == "source.fixAll.clang-tidy"
                  )
                end,
                apply = true,
              })
            end
          end

          vim.lsp.buf.format({ async = false })
        end,
        desc = "Format and fix document"
      },
    },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        debug = true,
        sources = {
          null_ls.builtins.formatting.clang_format,
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.diagnostics.eslint,

          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.isort,
          null_ls.builtins.diagnostics.flake8,
          null_ls.builtins.diagnostics.mypy,
          null_ls.builtins.diagnostics.ruff,
          null_ls.builtins.diagnostics.pylint,
          null_ls.builtins.code_actions.refactoring,

          null_ls.builtins.diagnostics.tsc,
          null_ls.builtins.formatting.prettierd,
          null_ls.builtins.code_actions.eslint_d,
        },
      })
    end,
  },
}
