-- 設置 leader 鍵
vim.g.mapleader = " "

-- 加載基礎設置
require("config.options")
require("config.keymaps")

-- 初始化 lazy.nvim
require("config.lazy")
