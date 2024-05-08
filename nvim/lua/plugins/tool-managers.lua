return {
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		build = ":MasonUpdate",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			require("mason").setup({
				PATH = "append",
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
					-- "pyright",
					"jedi_language_server",
					"sqlls",
					"esbonio",
					"svelte",
					"terraformls",
					"emmet_language_server",
					"ruff_lsp",
				},
			})
		end,
		dependencies = {
			"williamboman/mason.nvim",
		},
	},

	{
		"mrcjkb/rustaceanvim",
		ft = "rust",
    version = '^4',
	},
}
