"packloadall
set mouse=a
set showmode
set splitright
set encoding=UTF-8
set cursorline
set linespace=5
set linebreak
set ic
set tabstop=2
set shiftwidth=2
set smarttab

set ai
filetype off
set history=500

" Autoread a file when it changed in an another program
set autoread
au FocusGained,BufEnter * checktime

set so=7
set wildmenu
set wildmode=full
set ignorecase
set smartcase
set hlsearch
set incsearch
set magic
set noerrorbells
set novisualbell
set foldlevel=2
set foldnestmax=10
set nofoldenable

set foldcolumn=1
set foldmethod=syntax
set number
set scrolloff=8
set relativenumber
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set mouse=a

colorscheme desert
syntax enable

set noswapfile
set nobackup
set nowritebackup

let mapleader = " "

nnoremap <leader>pv :Vex<CR>
nnoremap <leader><CR> :so ~/.vimrc<CR>
nnoremap i :noh<cr>i
