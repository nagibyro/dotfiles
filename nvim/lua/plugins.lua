local function get_setup(name)
  return string.format('require("setup/%s")', name)
end

require("packer").startup(function(use)
  use({
    "wbthomason/packer.nvim",
  })

  use({
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({})
    end,
    after = "nvim-lspconfig",
  })

  use({
    "jayp0521/mason-null-ls.nvim",
    requires = {
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    },
    config = function()
      require("mason-null-ls").setup({
        ensure_installed = {
          "autoflake",
          "jq",
          "stylua",
          "write_good",
          "black",
          "isort",
          "pylint",
          "shellcheck",
          "taplo",
          "actionlint",
          "yamlfmt",
          "codespell",
        },
      })
    end,
    after = { "mason.nvim" },
  })

  use({
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
        },
      })
    end,
    requires = {
      { "williamboman/mason.nvim" },
    },
    after = "mason.nvim",
  })

  use({
    "neovim/nvim-lspconfig",
    config = get_setup("lsp"),
    requires = {
      "j-hui/fidget.nvim",
      "folke/neodev.nvim",
    },
  })

  use("j-hui/fidget.nvim")
  get_setup("fidget")

  use({
    "jose-elias-alvarez/null-ls.nvim",
    requires = {
      "neovim/nvim-lspconfig",
    },
    after = { "nvim-lspconfig", "mason.nvim" },
    config = get_setup("null_ls"),
  })

  use({
    "nvim-treesitter/nvim-treesitter",
    requires = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = get_setup("treesitter"),
    run = ":TSUpdate",
  })

  use({
    "nvim-tree/nvim-web-devicons",
    config = get_setup("dev_icons"),
  })

  use("tpope/vim-surround")
  use({
    "nvim-tree/nvim-tree.lua",
    requires = {
      { "nvim-tree/nvim-web-devicons" },
    },
    config = get_setup("tree"),
  })

  use("tpope/vim-commentary")

  use({
    "L3MON4D3/luaSnip",
    config = {
      get_setup("luasnip"),
    },
  })
  use("rafamadriz/friendly-snippets")

  use({
    "windwp/nvim-autopairs",
    config = get_setup("autopairs"),
  })
  -- Completion
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-nvim-lua" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "saadparwaiz1/cmp_luasnip" },
      { "onsails/lspkind.nvim" },
    },
    config = {
      get_setup("cmp"),
    },
  })
  -- Theme
  use({
    "EdenEast/nightfox.nvim",
    config = get_setup("theme"),
  })

  --project management
  use({
    "ahmedkhalf/project.nvim",
    config = {
      get_setup("project"),
    },
  })

  -- Telescope
  use({
    "nvim-telescope/telescope.nvim",
    config = {
      get_setup("telescope"),
    },
    requires = {
      { "nvim-lua/plenary.nvim" },
      { "BurntSushi/ripgrep" },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        run =
        "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
      },
    },
  })

  use({
    "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons",
    config = get_setup("trouble"),
  })

  --debugger
  use({
    "puremourning/vimspector",
    cmd = { "VimspectorInstall", "VimspectorUpdate" },
    fn = { "vimspector#Launch()", "vimspector#ToggleBreakpoint", "vimspector#Continue" },
    config = function()
      require(get_setup("vimspector")).setup()
    end,
  })

  --Markdown Previewer
  use({
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  })

  use({
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    "lewis6991/gitsigns.nvim",
    config = get_setup("gitsigns"),
  })

  use({
    "nvim-lualine/lualine.nvim",
    config = get_setup("lualine"),
  })

  use({
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    "akinsho/toggleterm.nvim",
    tags = "*",
    config = get_setup("toggleterm"),
  })

  use({
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    "folke/which-key.nvim",
    config = get_setup("which-key"),
  })
end)

local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  command = "source <afile> | PackerCompile",
  group = packer_group,
  pattern = vim.fn.expand("$MYVIMRC"),
})
