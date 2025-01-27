return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua",
          "vim",
          "typescript",
          "javascript",
          "python",
          "tsx",
          "html",
          "css",
          "json",
          "yaml",
          "markdown",
          "rust",
          "toml",
        },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
        autotag = { enable = true },
      })

      local install_dir = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/parser"
      vim.fn.mkdir(install_dir, "p")
    end,
  },
}
