"Byron's .vimrc file

filetype off
filetype plugin indent on
syntax on

set background=dark
set nocompatible
set modelines=0
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set encoding=utf-8
set scrolloff=3
set autoindent
set cindent cinoptions=+0
set showmode
set showcmd
set hidden  " Allow switching buffers without writing to disk
set wildmenu
set wildmode=list:longest
set visualbell
set ttyfast
set ruler " Always show cursor position
set backspace=indent,eol,start
set laststatus=2
set nobackup
set nowritebackup
set noswapfile
set history=1000
set undolevels=1000
set pastetoggle=<F2>

set nowrap
set textwidth=79
set formatoptions=qrn1

set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch

:nmap \l :setlocal number!<CR>
:nmap \o :set paste!<CR>

:nmap j gj
:nmap k gk

"folding settings
" set foldmethod=indent   "fold based on indent
" set foldnestmax=10      "deepest fold is 10 levels
" set nofoldenable        "dont fold by default
" set foldlevel=2         "this is just what i use

