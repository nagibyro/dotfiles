local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = ',';

-- escape
vim.api.nvim_set_keymap("i", "jk", "<esc>", {})

-- Nvim Tree
map("n", "<C-n>", ":NvimTreeFindFile<CR>", { silent = true })
map("n", "<leader>1", ":NvimTreeToggle<CR>", {silent = true })
vim.g.nvim_tree_show_icons = {
  git = 0,
  folders = 1,
  files = 1,
  folder_arrows = 1,
}
vim.g.nvim_tree_git_hl = 0

-- Telescope
map("n", "<leader>f", '<cmd>lua require("telescope.builtin").find_files()<cr>')
map("n", "<leader>s", '<cmd>lua require("telescope.builtin").live_grep()<cr>')

--map("n", "<leader>s", '<cmd>lua require("telescope.builtin").spell_suggest()<cr>')

map("n", "<leader>cr", '<cmd>lua require("telescope.builtin").lsp_references()<cr>')
map("n", "<leader>cd", '<cmd>lua require("telescope.builtin").lsp_definitions()<cr>')
map("n", "<leader>cs", '<cmd>lua require("telescope.builtin").lsp_document_symbols()<cr>')
