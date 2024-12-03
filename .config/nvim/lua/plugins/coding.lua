local py_utils = require("python-utils")
return {
	{
		-- parenthesis highlighting
		"utilyre/sentiment.nvim",
		version = "*",
		event = "VeryLazy",
		opts = {
			-- config
		},
		init = function()
			-- `matchparen.vim` needs to be disabled manually in case of lazy loading
			vim.g.loaded_matchparen = 1
		end,
	},

	{
		"NoahTheDuke/vim-just",
		ft = { "just" },
	},

  {
		"fladson/vim-kitty",
		event = "VeryLazy",
	},

	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				python = { "mypy" },
				htmldjango = { "djlint" },
				bash = { "shellcheck" },
				sh = { "shellcheck" },
				yaml = { "yamllint" },
				markdown = { "markdownlint" },
			}

      lint.linters.markdownlint = vim.tbl_deep_extend("force", lint.linters.markdownlint, {
        args = {
          "--config",
          "~/.config/markdownlint/markdownlint.json"
        }
      })

			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					lint.try_lint()
				end,
			})

      -- Add codespell linting for all file types
			for _, linter_list in pairs(lint.linters_by_ft) do
				table.insert(linter_list, "codespell")
			end

			if py_utils.venv_has("ruff") then
				table.insert(lint.linters_by_ft.python, "ruff")
			end

			if py_utils.venv_has("pylint") then
				table.insert(lint.linters_by_ft.python, "pylint")
			end

			vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
				group = lint_augroup,
				pattern = { "*.yaml", "*.yml" },
				callback = function()
					local path = vim.fn.expand("%:p")

					if string.match(path, "/.github/") then
						for key, value in pairs(lint.linters_by_ft.yaml) do
							if value == "actionlint" then
								return
							elseif value == "yamllint" then
								table.remove(lint.linters_by_ft.yaml, key)
							end
						end
						table.insert(lint.linters_by_ft.yaml, 1, "actionlint")
					else
						local found_action_lint = false
						local action_lint_key = nil

						local found_yaml_lint = false

						for key, value in pairs(lint.linters_by_ft.yaml) do
							if value == "actionlint" then
								found_action_lint = true
								action_lint_key = key
							end
							if value == "yamllint" then
								found_yaml_lint = true
							end
						end

						if found_action_lint and action_lint_key then
							table.remove(lint.linters_by_ft.yaml, action_lint_key)
						end

						if not found_yaml_lint then
							table.insert(lint.linters_by_ft.yaml, "yamllint")
						end
					end
				end,
			})

			vim.keymap.set("n", "<leader>l", function()
				lint.try_lint()
			end, { desc = "Trigger linting for current file" })
		end,
	},

	{
		"stevearc/conform.nvim",
		opts = {},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local conform = require("conform")
			conform.setup({
				formatters_by_ft = {
					lua = { "stylua" },
					python = function(bufnr)
						if conform.get_formatter_info("ruff_format", bufnr).available then
							return { "ruff_format", "ruff_fix" }
						elseif conform.get_formatter_info("black", bufnr).available then
							return { "black" }
						else
							return { "isort" }
						end
					end,
					just = { "just" },
					bash = { "shellcheck" },
					sh = { "shellcheck" },
					sql = { "sql_formatter" },
					htmldjango = { "djlint" },
					terraform = { "terraform_fmt" },
					hcl = { "terraform_fmt" },
					yaml = { "yamlfmt" },
					markdown = { "mdformat" },
				},
				format_on_save = {
					timeout_ms = 500,
					lsp_fallback = true,
				},
				formatters = {
					mdformat = {
						args = { "--wrap", "119" },
					},
				},
			})

			vim.keymap.set("n", "<leader>c", function()
				conform.format()
			end, { desc = "Trigger formatting for current file" })
		end,
	},
}
