
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
set shiftwidth=4
set tabstop=4

set list
set listchars=tab:>-,trail:~,extends:>,precedes:<

set ai
set si

if exists('+colorcolumn')
    set colorcolumn=80
endif
