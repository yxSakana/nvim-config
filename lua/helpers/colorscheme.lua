-- @file settings.lua
-- @date 2023-12-22 22:00
-- @author yx
-- @brief nvim colorscheme utils

local function get_if_avaliable(name, opt)
  local lua_ok, colorscheme = pcall(require, name)
  if lua_ok then
    colorscheme.setup(opt)
    return name
  end

  local vim_ok, _ = pcall(vim.cmd.colorscheme, name)
  if vim_ok then
    return name
  end

  return "default"
end

-- local colorscheme = get_if_avaliable("catppuccin")
local colorscheme = get_if_avaliable("tokyonight")

return colorscheme
