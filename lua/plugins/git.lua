return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
      "ibhagwan/fzf-lua",
      "echasnovski/mini.pick",
      "folke/snacks.nvim",
    },
    lazy = false,
    keys = {
      {
        "<leader>gg",
        ":Neogit<cr>",
        desc = "Open Neogit",
      },
    },
    opts = {
      signs = {
        section = { "", "" },
        item = { "", "" },
        hunk = { "", "" },
      },
    }
  },
}
