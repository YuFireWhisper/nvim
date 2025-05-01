return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufWritePost" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        javascript = { "eslint" },
        typescript = { "eslint", "tsc" },
        python = { "flake8", "mypy", "ruff", "pylint" },
        rust = {},
      }

      vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
        pattern = { "*.js", "*.ts", "*.py" },
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },
}
