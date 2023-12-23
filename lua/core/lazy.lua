-- @file lazy.lua
-- @date 2023-12-22 22:00
-- @author yx
-- @brief nvim lazy

-- lazy bootstap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local ok, lazy = pcall(require, "lazy")
if not ok then
	return
end

lazy.setup("plugins")
require("helpers.maps").map("n", "<leader>L", lazy.show, "Show Lazy")

