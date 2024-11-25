return {
  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      arg = "leetcode.nvim",
      lang = "cpp",
      cn = {
        enabled = true,
        translator = true,
        translate_problems = true,
      },
      storage = {
        home = vim.fn.stdpath("data") .. "/leetcode",
        cache = vim.fn.stdpath("cache") .. "/leetcode",
      },
      image_support = true,
      injector = {
        ["cpp"] = {
          before = {
            "#include <bits/stdc++.h>",
            "using namespace std;",
            "struct ListNode {",
            "    int val;",
            "    ListNode *next;",
            "    ListNode() : val(0), next(nullptr) {}",
            "    ListNode(int x) : val(x), next(nullptr) {}",
            "    ListNode(int x, ListNode *next) : val(x), next(next) {}",
            "};",
            "struct TreeNode {",
            "    int val;",
            "    TreeNode *left;",
            "    TreeNode *right;",
            "    TreeNode() : val(0), left(nullptr), right(nullptr) {}",
            "    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}",
            "    TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}",
            "};"
          },
        }
      },
      keymaps = {
        listing = {
          ["q"] = "quit",
          ["e"] = "enter",
          ["f"] = "filter",
          ["s"] = "sort",
          ["r"] = "reset",
          ["d"] = "description",
        },
        question = {
          ["r"] = "run",
          ["ss"] = "submit",
          ["ii"] = "info",
          ["cc"] = "case",
          ["tt"] = "template",
          ["dd"] = "description",
        },
      },
    },
  }
}

