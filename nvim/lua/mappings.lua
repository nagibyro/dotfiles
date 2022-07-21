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
map("n", "<leader>1", '<cmd>lua require("nvim-tree").toggle(false, true)<cr>')
vim.g.nvim_tree_show_icons = {
  git = 0,
  folders = 1,
  files = 1,
  folder_arrows = 1,
}
vim.g.nvim_tree_git_hl = 0

-- Telescope
-- * File Navigation
map("n", "<leader>ff", '<cmd>lua require("telescope.builtin").find_files()<cr>')
map("n", "<leader>fs", '<cmd>lua require("telescope.builtin").live_grep()<cr>')
map("n", "<leader>fo", '<cmd>lua require("telescope.builtin").oldfiles()<cr>')
map("n", "<leader>fp", '<cmd>Telescope projects<cr>')

map("n", "<leader>b", '<c-^>') -- toggle between the alternative file buffer and current


-- spelling
map("n", "<leader>ss", '<cmd>lua require("telescope.builtin").spell_suggest()<cr>')

-- * Code navigation
map("n", "<leader>cr", '<cmd>lua require("telescope.builtin").lsp_references()<cr>')
map("n", "<leader>cd", '<cmd>lua require("telescope.builtin").lsp_definitions()<cr>')
map("n", "<leader>cs", '<cmd>lua require("telescope.builtin").lsp_document_symbols()<cr>')
map("n", "<leader>cn", '<cmd>lua vim.lsp.buf.rename()<cr>')
map("n", "<leader>sh", '<cmd>lua vim.lsp.buf.signature_help()<cr>')

--Code trouble & hints
map("n", "<leader>xx", '<cmd>Trouble<cr>')
map("n", "<leader>xw", '<cmd>Trouble workspace_diagnostics<cr>')
map("n", "<leader>xd", '<cmd>Trouble document_diagnostics<cr>')
map("n", "<leader>xq", '<cmd>Trouble quickfix<cr>')
map("n", "<leader>xl", '<cmd>Trouble loclist<cr>')
map("n", "gR",'<cmd>Trouble lsp_references<cr>')
map("n", "K", '<cmd>lua vim.diagnostic.open_float()<cr>')
