return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "folke/neodev.nvim",
    },
    config = function()
      require("neodev").setup()
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
          "taplo",
        },
      })

      require("plugins.lsp.servers")
    end
  }
}
