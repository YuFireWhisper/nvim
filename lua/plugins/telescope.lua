return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
      },
    },
    cmd = 'Telescope',
    keys = {
      { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = '查找文件' },
      { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = '全局搜索' },
    },
    config = function()
      local telescope = require('telescope')

      telescope.setup({
        defaults = {
          path_display = { 'truncate' },
          sorting_strategy = 'ascending',
          file_ignore_patterns = {
            'node_modules',
            '.git/',
            'dist/',
            'build/',
          },
        },

        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = 'smart_case',
          },
        },
      })

      pcall(require('telescope').load_extension, 'fzf')
    end,
  }
}
