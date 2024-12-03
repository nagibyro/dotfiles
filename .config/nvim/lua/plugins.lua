local function get_setup(name)
	return function()
		local module_name = string.format("setup/%s", name)
		require(module_name)
	end
end

return {
	-- {
	--   "jose-elias-alvarez/null-ls.nvim",
	--   dependencies = {
	--     "neovim/nvim-lspconfig",
	--   },
	--   config = get_setup("null_ls"),
	-- },

	{
		"nvim-tree/nvim-web-devicons",
		config = get_setup("dev_icons"),
	},

	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
		},
		config = get_setup("tree"),
	},

	"tpope/vim-commentary",

	{
		"windwp/nvim-autopairs",
		config = get_setup("autopairs"),
	},
	-- Completion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{
				"L3MON4D3/luaSnip",
				version = "v2.*",
				build = "make install_jsregexp",
				config = {
					history = true,
					updateevents = "TextChanged,TextChangedI",
					enable_autosnippets = true,
				},
				dependencies = {
					"rafamadriz/friendly-snippets",
					config = function()
						require("luasnip.loaders.from_vscode").lazy_load()
					end,
				},
			},
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-path" },
			-- { "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "onsails/lspkind.nvim" },
		},
		config = get_setup("cmp"),
	},
	-- Theme
	{
		"EdenEast/nightfox.nvim",
		config = get_setup("theme"),
		lazy = false,
		priority = 1000,
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
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
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
		event = "VeryLazy",
		config = function()
			require("setup/vimspector").setup()
		end,
	},

	--Markdown Previewer
	-- {
	--   "iamcco/markdown-preview.nvim",
	--   build = "cd app && npm install",
	--   init = function()
	--     vim.g.mkdp_filetypes = { "markdown" }
	--   end,
	--   ft = { "markdown" },
	-- },

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
		"akinsho/toggleterm.nvim",
		version = "*",
		config = get_setup("toggleterm"),
	},

	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = get_setup("surround"),
	},

	{
		"microsoft/python-type-stubs",
		cond = false,
	},
}
