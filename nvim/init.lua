local vim = vim
local api = vim.api

vim.g.mapleader = " "                       -- leader key

vim.o.showmatch = true                      -- show matching brackets
vim.o.mouse = 'v'                           -- use mouse in visual mode
vim.o.hlsearch = true                       -- highlight search results
vim.o.wildmode = 'list:longest'             -- command-line completion mode

vim.o.colorcolumn = "80,120"                -- set color at column length

vim.o.listchars = "tab:>-,trail:·,extends:>,precedes:<" --invisible chars
vim.o.list = true                           -- show invisible chars

vim.o.wrap = false                          -- disable line wrap

vim.wo.number = true                        -- show line number for cursor
vim.wo.relativenumber = true                -- relative line numbers to cursor

vim.o.expandtab = true                     -- use spaces instead of tabs
vim.o.shiftwidth = 2                       -- size of indent
vim.o.softtabstop = 2                      -- see multiple spaces as stoptabs
vim.o.tabstop = 2                          -- number of spaces in a tab char
vim.o.textwidth=79                          -- max with of inserted text

vim.o.ignorecase = true                     -- ignore case in search
vim.bo.autoindent = true                    -- auto indent to previous line
vim.bo.smartindent = true
vim.o.termguicolors = true                  -- true color support

vim.o.syntax = 'on'                         -- syntax highlighting
vim.o.visualbell = true                     -- screen flash on errors

vim.o.smartcase = true                      -- case searchs with uppercase
vim.bo.swapfile = false                     -- dont use swap files
vim.o.backup = false                        -- dont make backup files
vim.o.incsearch = true

vim.wo.signcolumn = 'yes'
vim.o.scrolloff = 3           -- start scrolling before cursor reaches an edge
vim.o.sidescrolloff = 1       -- start scrolling before cursor reaches an edge

vim.opt.undofile = true; vim.bo.undofile = true --persistent undo

----- escape -----
api.nvim_set_keymap("i", "jk", "<esc>", {})

----- NerdTree Config -----
api.nvim_set_keymap("n", "<C-n>", ":NERDTreeToggle<CR>", {noremap = true})
api.nvim_set_keymap("n", "<leader>sf", ":NERDTreeFind<CR>", {noremap = true})

vim.cmd 'source ./nerdtree.vim'

require('plugins')
