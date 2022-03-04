vim.api.nvim_exec([[
 augroup Packer
  autocmd!
  autocmd BufWritePost plugins.lua PackerCompile
 augroup end
]], false)


-- Install packer
local execute = vim.api.nvim_command
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end

vim.cmd [[packadd packer.nvim]]

function get_setup(name)
  return string.format('require("setup/%s")', name)
end

require("packer").startup(function(use)
  use {
    'wbthomason/packer.nvim'
  }

  use 'neovim/nvim-lspconfig'
  use {
    'nvim-treesitter/nvim-treesitter',
    config = get_setup("treesitter"),
    run = ":TSUpdate",
  }
  

  use 'tpope/vim-surround'
  use 'scrooloose/nerdtree'
  use 'tpope/vim-commentary'
  use 'rafi/awesome-vim-colorschemes'
  use 'kyazdani42/nvim-web-devicons'
  use 'L3MON4D3/luaSnip'
  use 'windwp/nvim-autopairs'
--  use {
--    'nvim-lualine/lualine.nvim', 
--    config = get_setup("lualine"),
--    event = "VimEnter",
--    requires: { 'kyazdani42/nvim-web-devicons', opt = true }
--  }

-- Completion
use "hrsh7th/nvim-cmp"
use "hrsh7th/cmp-buffer"
use "hrsh7th/cmp-path"
use "hrsh7th/cmp-nvim-lua"
use "hrsh7th/cmp-nvim-lsp"
use "saadparwaiz1/cmp_luasnip"

-- Theme
use "EdenEast/nightfox.nvim"

end)

require'lspconfig'.yamlls.setup{}
require'lspconfig'.rust_analyzer.setup{}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.bashls.setup{}
require'lspconfig'.eslint.setup{}
require'lspconfig'.cssls.setup{}
require'lspconfig'.dockerls.setup{}
require'lspconfig'.html.setup{}
require'lspconfig'.jsonls.setup{}
