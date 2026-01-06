vim.lsp.enable("basedpyright")
vim.lsp.enable("lua_ls")
vim.lsp.enable("ts_ls")
vim.lsp.enable("bashls")
vim.lsp.enable("eslint")
vim.lsp.enable("cssls")
vim.lsp.enable("dockerls")
vim.lsp.enable("jsonls")
vim.lsp.enable("awk_ls")
vim.lsp.enable("ansiblels")
vim.lsp.enable("esbonio")
vim.lsp.enable("svelte")
vim.lsp.enable("terraformls") -- note workspace/didChangeConfiguration is not supported by tf lsp
vim.lsp.enable("html")
vim.lsp.enable("yamlls")
vim.lsp.enable("gh_actions_ls")

-- set lsp keymaps
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efintion")
		map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
		map("gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplemnations")
		map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
		map("gv", function()
			vim.cmd("vsplit")

			vim.schedule(function()
				require("telescope.builtin").lsp_definitions()
			end)
		end, "[G]o [V]ertial")
		map("<C-k>", vim.lsp.buf.signature_help, "Signature Help")
		map("<leader>cr", vim.lsp.buf.rename, "[C]ode [R]ename")
	end,
})

return {
	{
		-- LSP Progress Bar
		"j-hui/fidget.nvim",
		opts = {},
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason.nvim",
			"j-hui/fidget.nvim",
		},
	},
}
