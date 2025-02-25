return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "folke/neodev.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ts_ls",
          "pyright",
          "eslint",
          "cssls",
          "html",
          "emmet_ls",
          "tailwindcss",
          "clangd",
          "jsonls",
          "lua_ls",
          "rust_analyzer",
          "taplo",
        },
      })

      -- 載入伺服器配置
      require("plugins.lsp.servers")
    end
  }
}
