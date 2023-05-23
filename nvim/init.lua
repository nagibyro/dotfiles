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
vim.g.mapleader = "," --lazy needs leader key before running setup

require("options")
require("mappings")
require("plugins")

--python utils requires plugins to be loaded first
local python_utils = require("python-utils")
vim.g.python3_host_prog = python_utils.find_host_python()
