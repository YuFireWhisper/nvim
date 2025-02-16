return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    init = function()
      vim.g.neo_tree_remove_legacy_commands = true
    end,
    cmd = "Neotree",
    keys = {
      { "<F3>", "<cmd>Neotree toggle<cr>", desc = "切換檔案樹" },
      { "<leader>e", "<cmd>Neotree focus<cr>", desc = "聚焦檔案樹", silent = true },
    },
    opts = {
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
      window = {
        mappings = {
          ["<space>"] = "none",
        },
      },
      default_component_configs = {
        indent = {
          expander_collapsed = "",
          expander_expanded = "",
        },
      },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      icons = {
        breadcrumb = "»",
        separator = "➜",
        group = "+",
      },
    },
  },
  {
    "windwp/nvim-ts-autotag",
  },
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    event = "VeryLazy",
    config = function()
      require("tailwindcss-colorizer-cmp").setup()
    end,
  },
  {
    "laytan/tailwind-sorter.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim",
    },
    build = "cd formatter && npm i && npm run build",
    config = true,
  },
}
