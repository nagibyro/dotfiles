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
