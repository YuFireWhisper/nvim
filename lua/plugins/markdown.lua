return {
  {
    "iamcco/markdown-preview.nvim",
    event = "VeryLazy",
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
    config = function()
      local chrome_path = '/mnt/c/Program Files/Google/Chrome/Application/chrome.exe'
      vim.g.mkdp_browser = chrome_path
      vim.g.mkdp_host = 'localhost'
      vim.g.mkdp_port = '8080'
      vim.g.mkdp_theme = 'dark'
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_command_for_global = 0
      vim.g.mkdp_open_to_the_world = 1
      vim.g.mkdp_preview_options = {
        mkit = {},
        katex = {},
        uml = {},
        maid = {},
        disable_sync_scroll = 0,
        sync_scroll_type = 'middle',
        hide_yaml_meta = 1,
        sequence_diagrams = {},
        flowchart_diagrams = {},
        content_editable = false,
        disable_filename = 0,
        toc = {}
      }

      -- 定義 VimScript 函數
      vim.cmd([[
        function! OpenMarkdownPreview(url)
          call system(printf('powershell.exe Start-Process "%s"', a:url))
        endfunction
      ]])

      vim.g.mkdp_browserfunc = 'OpenMarkdownPreview'

      vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreview<CR>", { desc = "開啟 Markdown 預覽" })
      vim.keymap.set("n", "<leader>ms", "<cmd>MarkdownPreviewStop<CR>", { desc = "關閉 Markdown 預覽" })
    end,
  },
  {
    "preservim/vim-markdown",
    dependencies = "godlygeek/tabular",
    ft = "markdown",
    init = function()
      vim.g.vim_markdown_folding_disabled = 1
      vim.g.vim_markdown_conceal = 0
      vim.g.vim_markdown_conceal_code_blocks = 0
      vim.g.vim_markdown_math = 1
      vim.g.vim_markdown_frontmatter = 1
      vim.g.vim_markdown_strikethrough = 1
      vim.g.vim_markdown_autowrite = 1
      vim.g.vim_markdown_edit_url_in = 'tab'
      vim.g.vim_markdown_follow_anchor = 1
    end,
  },
}
