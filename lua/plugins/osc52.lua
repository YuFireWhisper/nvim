return {
  {
    "ojroques/nvim-osc52",
    config = function()
      require('osc52').setup {
        max_length = 0, -- 設為 0 表示無限制
        silent = false, -- 設為 true 會關閉通知
        trim = false,   -- 設為 true 會刪除尾部空格
      }

      -- 正確設置按鍵映射
      vim.keymap.set('n', 'y', require('osc52').copy_operator, { expr = true })
      vim.keymap.set('n', 'yy', function() return require('osc52').copy_operator() .. '_' end, { expr = true })
      vim.keymap.set('v', 'y', require('osc52').copy_visual)

      -- 設置 TextYankPost 自動複製
      vim.api.nvim_create_autocmd('TextYankPost', {
        callback = function()
          if vim.v.event.operator == 'y' and vim.v.event.regname == '' then
            require('osc52').copy_register('"')
          end
        end
      })
    end
  }
}

