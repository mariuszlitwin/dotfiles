
filetype plugin on
filetype indent on

command W w !sudo tee % > /dev/null

set number
set ruler
set ignorecase
set smartcase
set hlsearch
set incsearch
set showmatch
set encoding=utf8

syntax enable

set nobackup
set nowb

set expandtab
set smarttab
set shiftwidth=2
set tabstop=2

set list
set listchars=tab:>-,trail:~,extends:>,precedes:<

set ai
set si

if exists('+colorcolumn')
    set colorcolumn=100
endif

set directory=~/.vim/swap       " centralized swaps
set backupdir=~/.vim/backup     " centralized backups
set undodir=~/.vim/undo         " centralized undo history
