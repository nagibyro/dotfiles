return {
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		build = ":MasonUpdate",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			require("mason").setup({})
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
		"simrat39/rust-tools.nvim",
		ft = "rust",
		config = function()
			local rt = require("rust-tools")

			rt.setup({
				server = {
					on_attach = function(_, bufnr)
						vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
						vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
					end,
				},
			})
		end,
	},
}
