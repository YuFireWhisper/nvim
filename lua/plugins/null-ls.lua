return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>fm", vim.lsp.buf.format, desc = "Format document" },
    },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        debug = true,
        sources = {
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.diagnostics.eslint,
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.isort,
          null_ls.builtins.diagnostics.flake8,
          null_ls.builtins.formatting.clang_format,
        },
      })
    end,
  },
}
