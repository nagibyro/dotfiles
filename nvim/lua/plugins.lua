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

  use {
    'neovim/nvim-lspconfig',
    config = get_setup("lsp"),
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    config = get_setup("treesitter"),
    run = ":TSUpdate",
  }
  

  use 'tpope/vim-surround'
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      { "kyazdani42/nvim-web-devicons" }
    },
    config = get_setup("tree"),
  }

  use 'tpope/vim-commentary'
  use 'L3MON4D3/luaSnip'
  use {
    'windwp/nvim-autopairs',
    config = get_setup("autopairs"),
  }
--  use {
--    'nvim-lualine/lualine.nvim', 
--    config = get_setup("lualine"),
--    event = "VimEnter",
--    requires: { 'kyazdani42/nvim-web-devicons', opt = true }
--  }

-- Completion
use {
  "hrsh7th/nvim-cmp",
  requires = {
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-nvim-lua" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "saadparwaiz1/cmp_luasnip" },
  },
  config = {
    get_setup("cmp")
  }
}

-- Theme
use {
  "EdenEast/nightfox.nvim",
  config = get_setup("theme"),
}

-- Telescope
use {
  "nvim-telescope/telescope.nvim",
  requires = { 
    { "nvim-lua/plenary.nvim" },
    { "BurntSushi/ripgrep" },
    { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
  },
}

end)

