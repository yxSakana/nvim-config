-- @file settings.lua
-- @date 2023-12-22 22:00
-- @author yx
-- @brief nvim 设置

local settings = {
    -- 缩进 {{{
    shifwidth = 4, -- 自动缩进使用的空格数
    tabstop = 4, -- <Tab>插入的空格数
    expandtab = true, -- <Tab>缩进为空格
    -- }}}
    clipboard = "unnamedplus", -- 系统剪切板
    termguicolors = true, -- 终端启用彩色
    number = true, -- 显示行号
    relativenumber = false, -- 相对行号
    wrap = false, -- 防止包裹
    cursorline = true,  -- 高亮当前行
    mouse = true, -- 启用mouse
    -- 分割窗口默认 下 右 {{{
    splitright = true,
    splitbelow = true,
    -- }}}
    -- 搜素 {{{
    ignorecase = true,
    smartcase = true,
    -- }}}
    sighcolumn = "yes", -- 左侧多一列
    virtualedit = "block", -- 虚拟文本
    -- conceallevel = 0, -- 隐藏部分文本?
    undofile = true, -- 关闭文件仍可撤销
    updatetime = 100, -- 相应时间
}

for opt, val in pairs(settings) do
    vim.o[opt] = val
end

-- 打开文件,光标自动处于上次位置
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
        local line = vim.fn.line
        if line("'\"") > 1 and line("'\"") <= line("$") then
            vim.cmd("normal! g'\"")
        end
    end
})

-- 文本复制时,高亮提醒一下
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({ higroup="Visual", timeout=400 })
    end
})

