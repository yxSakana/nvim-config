local MAP = {}

-- @param mode(string | table) short-name
-- @param lhs(string) Left-hand side of the mapping
-- @param rhs(string | function) Right-hand side of the mapping
-- @param desc(string) desc of opts
MAP.map = function(mode, lhs, rhs, desc)
    -- @param mode(string | table) short-name => Normal|Insert|Visual|Select...
    -- @param lhs(string) Left-hand side of the mapping => 即快捷键
    -- @param rhs(string | function) Right-hand side of the mapping => 即对应的操作/命令
    -- @param opts(table | nil) map-arguments
    -- vim.keymap.set(mode, lhs, rhs, opts)
    vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc }) -- silent = true 执行映射时禁止命令行的输出
end

-- LSP Map
MAP.lsp_map = function(lhs, rhs, bufnr, desc)
    vim.keymap.set("n", lhs, rhs, { silent = true, buffer = bufnr, desc = desc })
end

MAP.dap_map = function(mode, lhs, rhs, desc)
    MAP.map(mode, lhs, rhs, desc)
end

MAP.set_leader = function(key)
    vim.g.mapleader = key
    vim.g.maplocalleader = key
    MAP.map({ "n", "v" }, key, "<nop>")
end

return MAP

