" Basics
set number
set relativenumber
set tabstop=2
set mouse=a
set clipboard=unnamed

" Appearance
syntax on
set termguicolors
set splitbelow
set cursorline
set splitright
set list
set listchars=tab:--,trail:•,eol:↲,space:·
set nofoldenable
set expandtab
colorscheme kyiv-sunrise

" Search
set incsearch
set ignorecase
set smartcase
set hlsearch


" Indentation
set smartindent
filetype plugin indent on

" Autocomplete
set wildmenu
set completeopt=menu,noselect

" Navigation
set scrolloff=8

function! WhichHighlight()
  let l:synID = synID(line("."), col("."), 1)
  let l:hlName = synIDattr(l:synID, "name")
  echo l:hlName
endfunction

function! CurrentGitBranch()
  if isdirectory('.git') || !empty(system('git rev-parse --git-dir 2>/dev/null'))
    return ' [' . system("git branch --show-current 2>/dev/null | tr -d '\n'") . ']'
  endif
  return ''
endfunction

nnoremap <C-h> :call WhichHighlight()<CR>

set statusline=%{CurrentGitBranch()}%m%F\ %y
