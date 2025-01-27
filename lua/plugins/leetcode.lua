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
    config = function()
      require("leetcode").setup({
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
      })

      vim.keymap.set("n", "<leader>rr", ":Leet run<CR>", { desc = "Run LeetCode solution" })
      vim.keymap.set("n", "<leader>su", ":Leet submit<CR>", { desc = "Submit LeetCode solution" })
      vim.keymap.set("n", "<leader>ll", ":Leet list<CR>", { desc = "List LeetCode problems" })
      vim.keymap.set("n", "<leader>li", ":Leet info<CR>", { desc = "Show problem info" })
      vim.keymap.set("n", "<leader>lr", ":Leet reset<CR>", { desc = "Reset code" })
      vim.keymap.set("n", "<leader>lt", ":Leet test<CR>", { desc = "Test solution" })
      vim.keymap.set("n", "<leader>ld", ":Leet desc<CR>", { desc = "Show problem description" })
    end,
  }
}
