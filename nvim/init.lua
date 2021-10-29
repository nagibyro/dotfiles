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

vim.bo.expandtab = true                     -- use spaces instead of tabs
vim.bo.shiftwidth = 2                       -- size of indent
vim.bo.softtabstop = 2                      -- see multiple spaces as stoptabs
vim.bo.tabstop = 2                          -- number of spaces in a tab char
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

require('plugins')
