return {
  {
    "folke/trouble.nvim",
    opts = {
      action_keys = {
        copy = "ye",
      }
    },
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle<cr>",                       desc = "Toggle Trouble" },
      { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics" },
      { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",  desc = "Document Diagnostics" },
      {
        "<leader>ec",
        function()
          local diagnostics = vim.diagnostic.get(0)
          if #diagnostics > 0 then
            local texts = {}
            for _, diagnostic in ipairs(diagnostics) do
              local line = diagnostic.lnum + 1
              local col = diagnostic.col + 1
              local text = string.format("[Line %d, Col %d] %s", line, col, diagnostic.message)
              table.insert(texts, text)
            end
            local diagnostic_text = table.concat(texts, "\n")
            vim.fn.setreg('+', diagnostic_text)
            vim.notify("Copied " .. #diagnostics .. " diagnostic messages to clipboard!")
          else
            vim.notify("No diagnostics to copy!")
          end
        end,
        desc = "Copy all diagnostics"
      },
      {
        "<leader>el",
        function()
          local current_line = vim.api.nvim_win_get_cursor(0)[1] - 1
          local diagnostics = vim.diagnostic.get(0, { lnum = current_line })
          if #diagnostics > 0 then
            local texts = {}
            for _, diagnostic in ipairs(diagnostics) do
              local line = diagnostic.lnum + 1
              local col = diagnostic.col + 1
              local text = string.format("[Line %d, Col %d] %s", line, col, diagnostic.message)
              table.insert(texts, text)
            end
            local diagnostic_text = table.concat(texts, "\n")
            vim.fn.setreg('+', diagnostic_text)
            vim.notify("Copied " .. #diagnostics .. " diagnostic messages from current line!")
          else
            vim.notify("No diagnostics on current line to copy!")
          end
        end,
        desc = "Copy line diagnostics"
      },
    },
  }
}
