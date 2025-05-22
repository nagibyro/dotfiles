local python_util = require("python-utils")
local override = require("plenary.lsp.override")

--local client_capabilities = vim.lsp.protocol.make_client_capabilities()
--client_capabilities.textDocument.completionItem.snippetSupport = true
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lsp_defaults = {
	flags = {
		debounce_text_changes = 150,
	},
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		local opts = { buffer = bufnr, remap = false }

		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover()
		end, opts)
		vim.keymap.set("n", "gd", function()
			vim.lsp.buf.definition()
		end, opts)
		vim.keymap.set("n", "gv", function()
			vim.cmd("vsplit")

			vim.schedule(function()
				vim.lsp.buf.definition()
			end)
		end, opts)
		vim.keymap.set("n", "gh", function()
			vim.cmd("split")

			vim.schedule(function()
				vim.lsp.buf.definition()
			end)
		end, opts)
		vim.keymap.set("n", "gD", function()
			vim.lsp.buf.declaration()
		end, opts)
		vim.keymap.set("n", "gi", function()
			vim.lsp.buf.implementation()
		end, opts)
		vim.keymap.set("n", "go", function()
			vim.lsp.buf.type_definition()
		end, opts)
		vim.keymap.set("n", "gr", function()
			require("telescope.builtin").lsp_references()
		end, opts)
		vim.keymap.set("n", "<C-k>", function()
			vim.lsp.buf.signature_help()
		end, opts)
		vim.keymap.set("n", "<leader>cr", function()
			vim.lsp.buf.rename()
		end, opts)
		vim.keymap.set("n", "<C-l>", function()
			vim.lsp.buf.code_action()
		end, opts)
		vim.keymap.set("n", "<leader>cf", function()
			vim.lsp.buf.format()
		end, opts)
		vim.keymap.set("x", "<F4>", function()
			vim.lsp.buf.range_code_action()
		end, opts)
		vim.keymap.set("n", "gl", function()
			vim.diagnostic.open_float()
		end, opts)
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.goto_prev()
		end, opts)
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.goto_next()
		end, opts)
	end,
}

return {
	{
		-- LSP Progress Bar
		"j-hui/fidget.nvim",
		opts = {},
	},

	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			-- options for vim.diagnostic.config()
			diagnostics = {
				underline = true,
				update_in_insert = false,
				virtual_text = {
					spacing = 4,
					source = "if_many",
					prefix = "●",
					-- this will set set the prefix to a function that returns the diagnostics icon based on the severity
					-- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
					-- prefix = "icons",
				},
				severity_sort = true,
			},
		},
		config = function(_, opts)
			local lspconfig = require("lspconfig")
			lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, lsp_defaults)
			lspconfig.lua_ls.setup({
				on_init = function(client)
					-- On init we check if we are in a lua project based on if there is a
					-- luarc.json or luarc.jsonc file if not then we assume we are using
					-- lua in neovim config and we set lsp settings to include the vim
					-- environment for completion and diagnostics ect...
					-- if client.workspace_folders then
					-- 	if vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc") then
					-- 		return
					-- 	end
					-- end

					client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
						runtime = {
							version = "LuaJIT",
						},
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
							},
						},
					})
				end,
				settings = {
					Lua = {
						telemetry = { enable = false },
					},
				},
			})
			lspconfig.yamlls.setup({
				settings = {
					yaml = {
						schemaStore = {
							enable = true,
						},
						format = {
							enable = true,
							bracketSpacing = true,
						},
						validate = true,
					},
					keyOrdering = false,
				},
			})
			lspconfig.ts_ls.setup({})
			lspconfig.bashls.setup({})
			lspconfig.eslint.setup({})
			lspconfig.cssls.setup({})
			lspconfig.dockerls.setup({})
			lspconfig.html.setup({
				filetypes = { "html", "htmldjango" },
			})
			lspconfig.jsonls.setup({})
			-- lspconfig.jedi_language_server.setup({})
			-- lspconfig.pyright.setup({
			-- 	on_init = function(client)
			-- 		client.config.settings.python.pythonPath = python_util.find_app_python(client.config.root_dir)

			-- 		if python_util.venv_has("mypy") then
			-- 			client.config.settings.python.analysis.typeCheckingMode = "off"
			-- 			client.config.settings.python.analysis.useLibraryCodeForTypes = false
			-- 		end

			-- 		if python_util.venv_has("ruff") or python_util.venv_has("isort") then
			-- 			client.config.settings.pyright.disableOrganizeImports = true
			-- 		end
			-- 	end,
			-- 	settings = {
			-- 		pyright = {
			-- 			disableOrganizeImports = false,
			-- 		},
			-- 		python = {
			-- 			analysis = {
			-- 				python_path = python_util.find_app_python_simple(),
			-- 				autoImportCompletions = true,
			-- 				autoSearchPaths = true,
			-- 				diagnosticMode = "workspace", -- "openFilesOnly"
			-- 				-- typeCheckingMode = "standard",
			-- 				useLibraryCodeForTypes = true,
			-- 				-- stubPath = vim.fn.stdpath("data") .. "/lazy/python-type-stubs",
			-- 			},
			-- 		},
			-- 	},
			-- })
			lspconfig.awk_ls.setup({})
			lspconfig.ansiblels.setup({})
			lspconfig.sqlls.setup({
				filetype = { "sql" },
			})
			lspconfig.esbonio.setup({})
			lspconfig.svelte.setup({})
			lspconfig.terraformls.setup({})
		end,
		dependencies = {
			"mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"j-hui/fidget.nvim",
			--{ "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
		},
	},
}
