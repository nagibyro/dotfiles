return {
	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		branch = "main",
		dependencies = {
			-- "nvim-treesitter/nvim-treesitter-textobjects",
			-- "nvim-treesitter/nvim-treesitter-context",
			"windwp/nvim-ts-autotag",
		},
		build = ":TSUpdate",
		config = function(_, opts)
			vim.treesitter.language.register("yaml", "ghaction")
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					pcall(vim.treesitter.start)
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
		opts = {
			playground = {
				enable = true,
			},
			-- highlight = { enable = true },
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
}
