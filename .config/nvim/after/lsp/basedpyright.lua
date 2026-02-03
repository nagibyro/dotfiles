local python_util = require("utils.python")
local lsp_utils = require("utils.lsp")

return {
	root_markers = {
		{
			"pyrightconfig.json",
			"pyproject.toml",
			"setup.py",
			"setup.cfg",
			"requirements.txt",
			"Pipfile",
		},
		".git",
	},
	settings = {
		basedpyright = {
			disableOrganizeImports = false,
			analysis = {
				autoImportCompletions = true,
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "openFilesOnly",
				-- stubPath = vim.fn.stdpath("data") .. "/lazy/python-type-stubs",
				diagnosticSeverityOverrides = {
					reportUnusedCallResult = "none",
				},
			},
		},
	},
	on_attach = function(client, bufnr)
		--use VENV if exists
		lsp_utils.patch_lsp_settings(client, function(settings)
			return {
				python = {
					pythonPath = python_util.find_app_python(client.config.root_dir),
				},
			}
		end)

		--if VENV has mypy we want to disable typechecking in pyright
		if python_util.venv_has("mypy") then
			lsp_utils.patch_lsp_settings(client, function(settings)
				return {
					basedpyright = {
						analysis = {
							typeCheckingMode = "off",
							useLibraryCodeForTypes = false,
						},
					},
				}
			end)
		end

		--if VENV has ruff or isort then use those instead of pyright organize
		--imports
		if python_util.venv_has("ruff") or python_util.venv_has("isort") then
			lsp_utils.patch_lsp_settings(client, function(settings)
				return {
					basedpyright = {
						disableOrganizeImports = true,
					},
				}
			end)

			client.handlers["textDocument/publishDiagnostics"] = function()
				-- This throws away all the diagnostics from basedpyright
				-- which we don't want any diagnostics showing up in vim's diagnostic
				-- subsystem from basedpyright if we are using ruff already
			end
		end
	end,
}
