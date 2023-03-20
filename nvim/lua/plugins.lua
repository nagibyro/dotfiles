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

local function get_setup(name)
  return string.format('require("setup/%s")', name)
end

require("packer").startup(function(use)
  use {
    'wbthomason/packer.nvim'
  }

  use {
    "williamboman/mason.nvim",
    config = function() require("mason").setup({}) end,
    after = "nvim-lspconfig",
  }

  use {
    "jayp0521/mason-null-ls.nvim",
    requires = {
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim"
    },
    config = function()
      require("mason-null-ls").setup({
        ensure_installed = {
          'autoflake',
          'jq',
          'stylua',
          'write_good',
          'black',
          'isort',
          'pylint',
          'shellcheck',
          'taplo',
          'actionlint',
          'yamlfmt',
          'codespell',
        },
      })
    end,
    after = {"mason.nvim"},
  }

  use {
    "williamboman/mason-lspconfig.nvim",
    config = function() 
      local mason_lsp = require("mason-lspconfig") 
      mason_lsp.setup({
        ensure_installed = {
          "lua_ls",
          "awk_ls",
          "ansiblels",
          "yamlls",
          "rust_analyzer",
          "tsserver",
          "bashls",
          "eslint",
          "cssls",
          "dockerls",
          "html",
          "jsonls",
          "pyright",
          "sqlls",
          "esbonio",
          "svelte",
          "terraformls",
        }
      })
    end,
    requires = {
      { "williamboman/mason.nvim" }
    },
    after = "mason.nvim",
  }

  use {
    'neovim/nvim-lspconfig',
    config = get_setup("lsp"),
  }

  use {
    "jose-elias-alvarez/null-ls.nvim",
    requires = {
      'neovim/nvim-lspconfig'
    },
    after = {"nvim-lspconfig", "mason.nvim"},
    config = get_setup("null_ls"),
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    config = get_setup("treesitter"),
    run = ":TSUpdate",
  }

  use {
    "nvim-tree/nvim-web-devicons",
    config = get_setup("dev_icons"),
  }


  use 'tpope/vim-surround'
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      { "nvim-tree/nvim-web-devicons" }
    },
    config = get_setup("tree"),
  }

  use 'tpope/vim-commentary'
  use 'L3MON4D3/luaSnip'
  use {
    'windwp/nvim-autopairs',
    config = get_setup("autopairs"),
  }
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

--project management
use {
  "ahmedkhalf/project.nvim",
  config = {
    get_setup("project")
  }
}

-- Telescope
use {
  "nvim-telescope/telescope.nvim",
  config = {
    get_setup("telescope")
  },
  requires = {
    { "nvim-lua/plenary.nvim" },
    { "BurntSushi/ripgrep" },
    { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
  },
}


use {
  "folke/trouble.nvim",
  requires = "nvim-tree/nvim-web-devicons",
  config = get_setup("trouble")
}

--debugger
use {
  "puremourning/vimspector",
  cmd = { "VimspectorInstall", "VimspectorUpdate" },
  fn = { "vimspector#Launch()",  "vimspector#ToggleBreakpoint", "vimspector#Continue" },
  config = function()
    require(get_setup("vimspector")).setup()
  end
}

--Markdown Previewer
use {
  "iamcco/markdown-preview.nvim",
  run = "cd app && npm install",
  setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
  ft = { "markdown" },
}

end)

