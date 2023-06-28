local function get_setup(name)
  return function()
    local module_name = string.format("setup/%s", name)
    require(module_name)
  end
end

require("lazy").setup({
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({})
    end,
  },

  {
    "jayp0521/mason-null-ls.nvim",
    dependencies = {
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
          "codelldb",
          "tflint",
        },
      })
    end,
  },

  {
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
    dependencies = {
      { "williamboman/mason.nvim" },
    },
  },

  {
    "neovim/nvim-lspconfig",
    config = get_setup("lsp"),
    dependencies = {
      "williamboman/mason.nvim",
      "j-hui/fidget.nvim",
      "folke/neodev.nvim",
    },
  },

  {
    "simrat39/rust-tools.nvim",
    config = get_setup("rust_tools"),
  },

  {
    "j-hui/fidget.nvim",
    config = get_setup("fidget"),
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    config = get_setup("null_ls"),
  },

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = get_setup("treesitter"),
    build = ":TSUpdate",
  },

  {
    "nvim-tree/nvim-web-devicons",
    config = get_setup("dev_icons"),
  },

  "tpope/vim-surround",

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
    },
    config = get_setup("tree"),
  },

  "tpope/vim-commentary",

  {
    "L3MON4D3/luaSnip",
    config = get_setup("luasnip"),
  },

  "rafamadriz/friendly-snippets",

  {
    "windwp/nvim-autopairs",
    config = get_setup("autopairs"),
  },
  -- Completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-nvim-lua" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "saadparwaiz1/cmp_luasnip" },
      { "onsails/lspkind.nvim" },
    },
    config = get_setup("cmp"),
  },
  -- Theme
  {
    "EdenEast/nightfox.nvim",
    config = get_setup("theme"),
  },

  --project management
  {
    "ahmedkhalf/project.nvim",
    config = get_setup("project"),
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    config = get_setup("telescope"),
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "BurntSushi/ripgrep" },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build =
        "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
      },
    },
  },

  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = get_setup("trouble"),
  },

  --debugger
  {
    "puremourning/vimspector",
    cmd = {
      "VimspectorInstall",
      "VimspectorUpdate",
      -- "vimspector#Launch()",
      -- "vimspector#ToggleBreakpoint",
      -- "vimspector#Continue",
    },
    config = function()
      require("setup/vimspector").setup()
    end,
  },

  --Markdown Previewer
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    "lewis6991/gitsigns.nvim",
    config = get_setup("gitsigns"),
  },

  {
    "nvim-lualine/lualine.nvim",
    config = get_setup("lualine"),
  },

  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    "akinsho/toggleterm.nvim",
    version = "*",
    config = get_setup("toggleterm"),
  },

  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    "folke/which-key.nvim",
    config = get_setup("which_key"),
  },
})
