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

