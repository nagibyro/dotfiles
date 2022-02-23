
----- escape -----
vim.api.nvim_set_keymap("i", "jk", "<esc>", {})

----- NerdTree Config -----
vim.api.nvim_set_keymap("n", "<C-n>", ":NERDTreeToggle<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>sf", ":NERDTreeFind<CR>", {noremap = true})

vim.cmd("source " .. vim.fn.stdpath('config') .. "/nerdtree.vim")

require('plugins')
require('options')
