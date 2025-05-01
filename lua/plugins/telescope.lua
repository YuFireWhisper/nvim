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

      vim.ui.select = function(items, opts, on_choice)
        local themes = require('telescope.themes')
        local actions = require('telescope.actions')
        local action_state = require('telescope.actions.state')

        local picker_opts = themes.get_dropdown({
          prompt_title = opts.prompt or 'Select',
          finder = require('telescope.finders').new_table({
            results = items,
            entry_maker = function(entry)
              return {
                value = entry,
                display = opts.format_item and opts.format_item(entry) or tostring(entry),
                ordinal = opts.format_item and opts.format_item(entry) or tostring(entry),
              }
            end,
          }),
          sorter = require('telescope.sorters').get_generic_fuzzy_sorter(),
          attach_mappings = function(prompt_bufnr, _)
            actions.select_default:replace(function()
              local selection = action_state.get_selected_entry()
              actions.close(prompt_bufnr)
              on_choice(selection.value)
            end)
            return true
          end,
        })

        require('telescope.pickers').new({}, picker_opts):find()
      end
    end,
  }
}
