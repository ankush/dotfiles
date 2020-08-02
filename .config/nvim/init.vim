" NEOVIM CONFIGURATION FILE
source $HOME/.config/nvim/plugins.vim
source $HOME/.config/nvim/keybindings.vim

colorscheme dracula
set ruler " Show cursor position all the time
set cursorline " highlight current line
set nocompatible " Disable ancient compatibility
syntax on " Turn on syntax highlighting.
set shortmess+=I " Disable the default Vim startup message.
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set softtabstop=0
set expandtab
"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set ttyfast
set number " show absolute line number on current line
set relativenumber " show relative line number on all other lines
set laststatus=2  " Always show the status line at the bottom
set backspace=indent,eol,start " Disable awkward backspace behaviour
set hidden " Allows hiding unsaved buffers
set ignorecase " Ignore case
set smartcase " Consider case if caps are present
set incsearch " Search while still typing
set noerrorbells visualbell t_vb= " Disable bell
set mouse+=a " Enable mouse support
set clipboard=unnamedplus  " Use the system clipboard by default
set history=2000
set inccommand=nosplit
set lazyredraw " Don't redraw when running macros
set noswapfile  " Don't use a swapfile for the buffer
set nospell " disable spell-check
set nojoinspaces  " Use one space, not two, after punctuation
"set colorcolumn=80 " Colour column to show 79 char limit
set scrolloff=5 " Show at least 5 extra lines while scrolling
hi Normal guibg=NONE ctermbg=NONE
set showtabline=2
