local opt = vim.opt

-- UI 相關
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true        -- 啟用換行
    vim.opt_local.linebreak = false  -- 在單詞邊界換行
    vim.opt_local.breakindent = true -- 保持縮進
  end
})

-- 搜索相關
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- 縮進相關
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = false
opt.autoindent = true
opt.cindent = true

-- 系統相關
opt.mouse = 'a'
opt.clipboard = 'unnamedplus'

-- 文件相關
opt.swapfile = false
opt.backup = false
opt.undofile = true

-- 編輯體驗
opt.showmode = false -- 使用 lualine 的情況下不需要顯示模式
opt.updatetime = 100 -- 更快的更新時間（預設是 4000ms）
opt.timeoutlen = 300 -- 更快的按鍵響應

-- 分割窗口
opt.splitright = true -- 新窗口從右邊出現
opt.splitbelow = true -- 新窗口從下邊出現

-- 命令行
opt.cmdheight = 1
opt.pumheight = 10 -- 彈出菜單的最大高度

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
