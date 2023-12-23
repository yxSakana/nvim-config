-- @file keymaps.lua
-- @date 2023-12-22 22:00
-- @author yx
-- @brief nvim keymaps


local map = require("helpers.maps").map

-- leader
require("helpers.maps").set_leader(" ")

-- 退出与保存
map("n", "<leader>fw", "<cmd>w<cr>", "Write")
map("n", "<leader>fs", "<cmd>wa<cr>", "Write all")
map("n", "<leader>qq", "<cmd>q<cr>", "Quit")
map("n", "<leader>qa", "<cmd>qa!<cr>", "Quit all")
map("n", "<leader>qw", "<cmd>close<cr>", "Window")

-- 行内跳转
map("n", "<M-h>", "^", "Go to beginning of line")
map("n", "<M-l>", "$", "Go to end of line")

-- 窗口跳转
map("n", "<C-h>", "<C-w><C-h>", "Navigate windows to the left")
map("n", "<C-j>", "<C-w><C-j>", "Navigate windows down")
map("n", "<C-k>", "<C-w><C-k>", "Navigate windows up")
map("n", "<C-l>", "<C-w><C-l>", "Navigate windows to the right")

-- Navigate 跳转
map("n", "<S-l>", ":bnext<CR>")
map("n", "<S-h>", ":bprevious<CR>")

-- 窗口大小调整
map("n", "<C-Up>", ":resize +2<CR>")
map("n", "<C-Down>", ":resize -2<CR>")
map("n", "<C-Left>", ":vertical resize +2<CR>")
map("n", "<C-Right>", ":vertical resize -2<CR>")

-- 窗口分割
map("n", "<leader>sv", "<C-w>v")
map("n", "<leader>sh", "<C-w>s")

-- Visual
map("v", "<", "<gv")
map("v", ">", ">gv")
map("v", "J", ":m '>+1<CR>gv=gv") -- 选中行按行移动
map("v", "K", ":m '<-2<CR>gv=gv")
map("n", "<leader>nh", ":nohl<CR>") -- 取消高亮

-----------------------
--   Plugins keymaps -- 
-----------------------
-- require("helpers.maps").map("n", "<leader>L", lazy.show, "Show Lazy")

