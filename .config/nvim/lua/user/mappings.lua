-- escape
vim.keymap.set("i", "jk", "<esc>", { desc = "Exit insert mode. Alt for [ESC]" })

-- keep copied value when pasting over text
vim.keymap.set("x", "p", [["_dP]])

-- Nvim Tree
vim.keymap.set(
	"n",
	"<C-n>",
	":NvimTreeFindFile<CR>",
	{ desc = "Open NvimTree at file in current buffer", silent = true }
)
vim.keymap.set(
	"n",
	"<leader>1",
	'<cmd>lua require("nvim-tree").toggle(false, true)<cr>',
	{ desc = "Toggle NvimTree Window" }
)

-- Telescope
-- * File Navigation
vim.keymap.set(
	"n",
	"<leader>fw",
	'<cmd>lua require("telescope.builtin").grep_string({search = vim.fn.expand("<cword>")})<cr>',
	{ desc = "Grep for word under cursor" }
)
vim.keymap.set("n", "<leader>ff", '<cmd>lua require("telescope.builtin").find_files()<cr>', { desc = "Find Files" })
vim.keymap.set(
	"n",
	"<leader>fs",
	'<cmd>lua require("telescope.builtin").live_grep()<cr>',
	{ desc = "Search contents of files" }
)
vim.keymap.set(
	"n",
	"<leader>fo",
	'<cmd>lua require("telescope.builtin").oldfiles()<cr>',
	{ desc = "Find recent files" }
)
vim.keymap.set(
	"n",
	"<leader>fh",
	'<cmd>lua require("telescope.builtin").help_tags()<cr>',
	{ desc = "Search neovim and plugin help pages" }
)
vim.keymap.set("n", "<leader>fp", "<cmd>Telescope projects<cr>")

vim.keymap.set("n", "<leader>b", "<c-^>") -- toggle between the alternative file buffer and current

-- spelling
vim.keymap.set("n", "<leader>ss", '<cmd>lua require("telescope.builtin").spell_suggest()<cr>')

-- * Code navigation
vim.keymap.set("n", "<leader>cr", '<cmd>lua require("telescope.builtin").lsp_references()<cr>')
vim.keymap.set("n", "<leader>cd", '<cmd>lua require("telescope.builtin").lsp_definitions()<cr>')
vim.keymap.set("n", "<leader>cs", '<cmd>lua require("telescope.builtin").lsp_document_symbols()<cr>')
vim.keymap.set("n", "<leader>cw", '<cmd>lua require("telescope.builtin").lsp_dynamic_workspace_symbols()<cr>')

--Code trouble & hints
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble<cr>")
vim.keymap.set("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>")
vim.keymap.set("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>")
vim.keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix<cr>")
vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist<cr>")

vim.keymap.set("n", "<leader>dG", '<cmd>lua require("setup/vimspector").generate_debug_profile()<cr>')
vim.keymap.set("n", "<leader>dI", "<cmd>call vimspector#Install()<cr>")
vim.keymap.set("n", "<leader>dU", "<cmd>call vimspector#Update()<cr>")
vim.keymap.set("n", "<leader>dr", "<cmd>call vimspector#RunToCursor()<cr>")
vim.keymap.set("n", "<leader>dc", "<cmd>call vimspector#Continue()<cr>")
vim.keymap.set("n", "<leader>di", "<cmd>call vimspector#StepInto()<cr>")
vim.keymap.set("n", "<leader>do", "<cmd>call vimspector#StepOver()<cr>")
vim.keymap.set("n", "<leader>ds", "<cmd>call vimspector#Launch()<cr>")
vim.keymap.set("n", "<leader>dt", "<cmd>call vimspector#ToggleBreakpoint()<cr>")
vim.keymap.set("n", "<leader>dS", "<cmd>call vimspector#Stop()<cr>")
vim.keymap.set("n", "<leader>dR", "<cmd>call vimspector#Restart()<cr>")
vim.keymap.set("n", "<leader>dx", "<cmd>VimspectorReset<cr>")
vim.keymap.set("n", "<leader>dH", '<cmd>lua require("setup/vimspector").toggle_human_mode()<cr>')

vim.keymap.set("n", "<leader>pd", function()
	local current_file = vim.fn.expand("%")

	local python_utils = require("python-utils")

	local dot_notation = python_utils.get_import_path(current_file)

	vim.notify(dot_notation, vim.log.levels.INFO, { title = "current python file dot" })
end)

vim.keymap.set("n", "<leader>ai", "<cmd>CodeCompanionChat Toggle<cr>")
