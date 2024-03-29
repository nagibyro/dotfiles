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
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				python = { "pylint", "mypy" },
				htmldjango = { "djlint" },
				bash = { "shellcheck" },
				sh = { "shellcheck" },
				yaml = { "yamllint" },
			}

			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					require("lint").try_lint()
				end,
			})

			vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
				group = lint_augroup,
				pattern = { "*.yaml", "*.yml" },
				callback = function()
					local path = vim.fn.expand("%:p")

					if string.match(path, "/.github/") then
						table.insert(lint.linters_by_ft.yaml, 1, "actionlint")
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
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					python = function(bufnr)
						local conform = require("conform")
						if conform.get_formatter_info("ruff_format", bufnr).available then
							return { "ruff_format" }
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
					["*"] = { "codespell" },
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
		end,
	},
}
