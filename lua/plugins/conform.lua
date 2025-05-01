return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    opts = {
      formatters_by_ft = {
        c = { "clang_format" },
        cpp = { "clang_format" },
        javascript = { "prettierd", "prettier" },
        typescript = { "prettierd", "prettier" },
        python = { "isort", "black" },
        rust = {}
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      format = {
        timeout_ms = 3000,
        async = false,
        quiet = false,
      },
    },
    keys = {
      {
        "<leader>fm",
        function()
          require("conform").format({ async = false, lsp_fallback = true })
        end,
        desc = "Format document",
      },
    },
  },
}
