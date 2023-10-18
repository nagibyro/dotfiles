local vim = vim
local opt = vim.opt
local api = vim.api

vim.o.showmatch = true                                  -- show matching brackets
vim.o.mouse = "nv"                                      -- use mouse in visual & normal mode
vim.o.hlsearch = true                                   -- highlight search results
vim.o.wildmode = "list:longest"                         -- command-line completion mode

vim.o.colorcolumn = "99,120"                            -- set color at column length

vim.o.listchars = "tab:>-,trail:·,extends:>,precedes:<" --invisible chars
vim.o.list = true                                       -- show invisible chars

vim.o.wrap = false                                      -- disable line wrap

vim.wo.number = true                                    -- show line number for cursor
vim.wo.relativenumber = true                            -- relative line numbers to cursor

vim.o.expandtab = true                                  -- use spaces instead of tabs
vim.o.shiftwidth = 2                                    -- size of indent
opt.shiftround = true                                   -- round indents
vim.o.softtabstop = 2                                   -- see multiple spaces as stoptabs
vim.o.tabstop = 2                                       -- number of spaces in a tab char
vim.o.textwidth = 79                                    -- max with of inserted text

vim.o.ignorecase = true                                 -- ignore case in search
vim.bo.autoindent = true                                -- auto indent to previous line
vim.bo.smartindent = true
vim.o.termguicolors = true                              -- true color support

vim.o.syntax = "on"                                     -- syntax highlighting
vim.o.visualbell = true                                 -- screen flash on errors

vim.o.smartcase = true                                  -- case searches with uppercase
vim.bo.swapfile = false                                 -- dont use swap files
vim.o.backup = false                                    -- dont make backup files
vim.o.incsearch = true                                  -- show match while typing
opt.inccommand = "split"                                -- get a preview of replacements

--vim.wo.signcolumn = "auto:2-6"
--vim.wo.signcolumn = "no"
vim.o.scrolloff = 3     -- start scrolling before cursor reaches an edge
vim.o.sidescrolloff = 1 -- start scrolling before cursor reaches an edge

vim.opt.undofile = true
vim.bo.undofile = true                              --persistent undo

opt.clipboard = "unnamedplus"                       -- use system clipboard see :h clipboard
opt.completeopt = { "menu", "menuone", "noselect" } -- configure auto complete options
opt.cursorline = false
opt.cursorcolumn = false
opt.encoding = "utf-8"
opt.foldenable = false
opt.foldmethod = "indent"
opt.formatoptions = "l"
opt.hidden = true -- enable background buffers
vim.o.lazyredraw = true
opt.linebreak = true
opt.showmode = false
opt.splitbelow = true
opt.splitright = true

vim.o.exrc = true
