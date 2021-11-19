-- Install packer
local execute = vim.api.nvim_command
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end

vim.cmd [[packadd packer.nvim]]
vim.api.nvim_exec([[
 augroup Packer
  autocmd!
  autocmd BufWritePost plugins.lua PackerCompile
 augroup end
]], false)

packer = require 'packer'

packer.init {}

local use = packer.use
packer.reset()
packer.startup(function()
  use {
    'wbthomason/packer.nvim'
  }

  use 'neovim/nvim-lspconfig'

  use 'scrooloose/nerdtree'
  use 'preservim/nerdcommenter'
end)

require'lspconfig'.yamlls.setup{}
require'lspconfig'.rust_analyzer.setup{}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.bashls.setup{}

