"Byron's .vimrc file
filetype off
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on
syntax on

let mapleader = ","

"nerdtree
"open nerdtree when opening a file
autocmd VimEnter * NERDTree

"if nerdtree is the only open window quit
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"if vim opened with no arugments open blank nerdtree instance
autocmd vimenter * if !argc() | NERDTree | endif

let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\swp$', '\.git', '\.hg', '\.svn', '\.bzr']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1

map <C-n> :NERDTreeToggle<CR>
map <leader>n :NERDTreeFind<CR>
nmap <leader>nt :NERDTreeFind<CR>

"general settings
set mouse=a     "Automatically enbale mouse usage
set mousehide   "hide mouse while typeing

set virtualedit=onemore "allow for cursor byeond last character
set history=1000 

"Instead of having the cursor in the last position in the buffer
"set the cursor to the first line of the file when editing git commit messages
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

set nu
set winminheight=0

set background=dark
set nocompatible
set modelines=0
set expandtab
set encoding=utf-8
set scrolloff=3
set cindent cinoptions=+0
set showmode
set showcmd
set hidden  " Allow switching buffers without writing to disk
set wildmenu
set wildmode=list:longest,full
set ttyfast
set ruler " Always show cursor position
set backspace=indent,eol,start
set laststatus=2
set nobackup
set nowritebackup
set noswapfile
set history=1000
set undolevels=1000
set whichwrap+=<,>,h,l,[,]

"formatting
set nowrap
set shiftwidth=4
set tabstop=4
set softtabstop=4
set autoindent
set textwidth=79
set formatoptions=qrn1
set splitright
set splitbelow

set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch

:nmap \l :setlocal number!<CR>
:nmap \o :set paste!<CR>

noremap  j gj
noremap  k gk

noremap $ g$
noremap <End> g<End>
noremap <Home>  g<Home> 
noremap ^ g^

nnoremap Y y$


"folding settings
set foldenable 
" set foldmethod=indent   "fold based on indent
" set foldnestmax=10      "deepest fold is 10 levels
" set nofoldenable        "dont fold by default
" set foldlevel=2         "this is just what i use

