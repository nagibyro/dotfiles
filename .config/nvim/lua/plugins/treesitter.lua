return {
	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		dependencies = {
			-- "nvim-treesitter/nvim-treesitter-textobjects",
			-- "nvim-treesitter/nvim-treesitter-context",
			"windwp/nvim-ts-autotag",
		},
		build = ":TSUpdate",
		config = function(_, opts)
			-- Config function is required for treesitter because it's special see
			-- https://github.com/folke/lazy.nvim/issues/1011#issuecomment-1695857124
			--
			-- TLDR lazy-nvim when you don't have a config function tries to find the
			-- module setup function at the root of the module aka
			-- nvim-treesitter.setup() However treesitter's setup function is in a
			-- submodule "nvim-treesitter.configs" and this just fails silently
			-- withou the config function. so we call that here.
			require("nvim-treesitter.configs").setup(opts)
		end,
		opts = {
			playground = {
				enable = true,
			},
			highlight = { enable = true },
			rainbow = {
				enable = true,
				extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
				max_file_lines = nil, -- Do not enable for files with more than n lines, int
			},
			autotag = {
				enable = true,
				filetypes = {
					"html",
					"htmldjango",
					"javascript",
					"typescript",
					"markdown",
				},
			},
			-- incremental_selection = {
			-- 	enable = true,
			-- 	keymaps = {
			-- 		init_selection = "<CR>",
			-- 		scope_incremental = "<CR>",
			-- 		node_incremental = "<CR>",
			-- 		node_decremental = "<TAB>",
			-- 	},
			-- },
			ensure_installed = {
				"bash",
				"lua",
				"luadoc",
				"luap",
				"rust",
				"c",
				"comment",
				"dockerfile",
				"elixir",
				"erlang",
				"go",
				"gomod",
				"gowork",
				"graphql",
				"git_config",
				"gitcommit",
				"gitignore",
				"ini",
				"hcl",
				"html",
				"htmldjango",
				"http",
				"java",
				"javascript",
				"jsdoc",
				"json",
				"json5",
				"make",
				"markdown",
				"perl",
				"php",
				"python",
				"regex",
				"svelte",
				"ssh_config",
				"sql",
				"toml",
				"tsx",
				"typescript",
				"terraform",
				"vim",
				"vimdoc",
				"vue",
				"yaml",
			},
		},
	},

	-- Automatically add closing tags for HTML and JSX
	{
		"windwp/nvim-ts-autotag",
	},

	{
		"nvim-treesitter/playground",
	},
}
