local py_utils = require("utils.python")
return {
	{
		-- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},
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
				python = { "mypy" },
				htmldjango = { "djlint" },
				bash = { "shellcheck" },
				sh = { "shellcheck" },
				yaml = { "yamllint" },
				markdown = { "markdownlint" },
				ghaction = { "actionlint" },
			}

			lint.linters.markdownlint = vim.tbl_deep_extend("force", lint.linters.markdownlint, {
				args = {
					"--config",
					"~/.config/markdownlint/markdownlint.json",
				},
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

			-- I'm not using pylint in any project right now and apparently some
			-- packages pull in pylint as a depedency???? Maybe istead of venv has we
			-- need to check pyproject.toml directly?
			-- if py_utils.venv_has("pylint") then
			-- 	table.insert(lint.linters_by_ft.python, "pylint")
			-- end

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

	{
		"folke/trouble.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
}
