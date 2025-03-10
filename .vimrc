source /etc/vimrc
syntax on
set showmode

inoremap <Up> <Up>
inoremap <Down> <Down>
inoremap <Left> <Left>
inoremap <Right> <Right>
inoremap <Del> <Del>

set number
set cursorline
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set wrap
set showmatch
set incsearch
set hlsearch
set undofile
set background=dark
colorscheme koehler


filetype plugin indent on
set foldmethod=syntax
set clipboard=unnamedplus
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim//undo//
" set showmode



