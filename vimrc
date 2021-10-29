"Byron's .vimrc file
filetype off
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on
syntax on

let mapleader = ","
set relativenumber

"ctags
"this option will look for a tags file called tags in current dirctory and then
"in the parent directory, and so on recursivly up to ~/projects
set tags=./tags;~/projects

colorscheme koehler

"nerdtree
"open nerdtree when opening a file
"autocmd VimEnter * NERDTree

"if nerdtree is the only open window quit
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"if vim opened with no arugments open blank nerdtree instance
autocmd vimenter * if !argc() | NERDTree | endif

let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\swp$', '\.git', '\.hg', '\.svn', '\.bzr', '\.DS_Store', '\._.DS_Store']
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

set virtualedit=onemore "allow for cursor beyond last character
set history=1000 

"Instead of having the cursor in the last position in the buffer
"set the cursor to the first line of the file when editing git commit messages
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

set nu
set winminheight=0

set visualbell
set t_vb=
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
set backupcopy=yes 
set noswapfile
set history=1000
set undolevels=1000
set whichwrap+=<,>,h,l,[,]

"formatting
set nowrap
set shiftwidth=2
set tabstop=2
set softtabstop=2
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

"open vim rc in a split window with Leader(ev) and source with Leader(sv)
:noremap <leader>ev :vsplit $MYVIMRC<cr>
:noremap <leader>sv :source $MYVIMRC<cr>

"acts as escape in insert mode and force myself to learn it
:inoremap <esc> <nop>
:inoremap jk <esc>

noremap $ g$
noremap <End> g<End>
noremap <Home>  g<Home> 
noremap ^ g^

nnoremap Y y$

"this adds functionality so that opening and closing parens are created 
inoremap        (   ()<Left>
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}

"folding settings
set foldenable 
" set foldmethod=indent   "fold based on indent
" set foldnestmax=10      "deepest fold is 10 levels
" set nofoldenable        "dont fold by default
" set foldlevel=2         "this is just what i use

"Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatusLineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"vim.go settings
let g:go_disable_autoinstall = 1
let g:go_fmt_autosave = 0

"airline settings
let g:airline_powerline_fonts = 1
let g:airline#extensions#syntastic#enable = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
function! AirlineInit()
    "let g:airline_section_c = airline#section#create(['%{getcwd()}'])
endfunction
autocmd User AirlineAfterInit call AirlineInit()
