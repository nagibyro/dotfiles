local function get_setup(name)
	return function()
		local module_name = string.format("setup/%s", name)
		require(module_name)
	end
end

return {
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
	{
		-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
		-- used for completion, annotations and signatures of Neovim apis
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	-- Completion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{
				"L3MON4D3/luaSnip",
				build = (function()
					return "make install_jsregexp"
				end)(),
				opts = {
					history = true,
					updateevents = "TextChanged,TextChangedI",
					enable_autosnippets = true,
				},
				dependencies = {
					"rafamadriz/friendly-snippets",
					config = function()
						require("luasnip.loaders.from_vscode").lazy_load()
						require("luasnip.loaders.from_lua").load({ paths = vim.fn.stdpath("data") .. "/snippets" })
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
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local select_opts = { behavior = cmp.SelectBehavior.Select }
			luasnip.config.setup({})

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				completion = { completeopt = "menu,menuone,noinsert" },

				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(select_opts),
					["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-u>"] = cmp.mapping.scroll_docs(4),
					["<C-e>"] = cmp.mapping.close(),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<C-s>"] = cmp.mapping({
						i = cmp.mapping.complete(),
					}),
					["<C-j>"] = cmp.mapping.complete(),

					-- Think of <c-l> as moving to the right of your snippet expansion.
					--  So if you have a snippet that's like:
					--  function $name($args)
					--    $body
					--  end
					--
					-- <c-l> will move you to the right of each of the expansion locations.
					-- <c-h> is similar, except moving you backwards.
					["<C-l>"] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { "i", "s" }),
					["<C-h>"] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),

					-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
					--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
				}),
				sources = {
					{
						name = "lazydev",
						group_index = 0,
					},
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
				},
			})
		end,
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
