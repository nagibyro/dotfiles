return {
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup({
				PATH = "append",
			})
		end,
	},
	{
		"mrcjkb/rustaceanvim",
		ft = "rust",
		version = "^4",
	},
}
