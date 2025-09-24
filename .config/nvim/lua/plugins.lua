local function get_setup(name)
	return function()
		local module_name = string.format("setup/%s", name)
		require(module_name)
	end
end

return {
	{
		"nvim-tree/nvim-web-devicons",
		opts = {},
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
	-- Theme
	{
		"EdenEast/nightfox.nvim",
		config = get_setup("theme"),
		lazy = false,
		priority = 1000,
	},

	--debugger
	{
		"puremourning/vimspector",
		event = "VeryLazy",
		config = function()
			require("setup/vimspector").setup()
		end,
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
		"microsoft/python-type-stubs",
		cond = false,
	},
}
