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
set numberwidth=5
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
set history=1000
set inccommand=nosplit
set lazyredraw " Don't redraw when running macros
set noswapfile  " Don't use a swapfile for the buffer
set spelllang=en_gb " enable spell-check
set spellfile=$HOME/.config/nvim/spell/en.utf-8.add
set nojoinspaces  " Use one space, not two, after punctuation
"set colorcolumn=80 " Colour column to show 79 char limit
set scrolloff=5 " Show at least 5 extra lines while scrolling
set showtabline=2 " Enable bufferline on top
set splitbelow  " Put new window below current one when splitting
set splitright  " Put new window to the right of the current one when splitting
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

" required by Coc
set nobackup
set nowritebackup
set updatetime=500

" Trim whitespace on save for all files
autocmd BufWritePre * :%s/\s\+$//e

" set default locations for opening new window
set splitbelow
set splitright

" Disable modlines
set modelines=0
set nomodeline

" enable true color support
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" When editing a file, always jump to the last known cursor position.
" Don't do it for commit messages, when the position is invalid, or when
" inside an event handler (happens when dropping a file on gvim).
autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif


set list   " show whitespace
set listchars=tab:│·,extends:›,precedes:‹,nbsp:⦸,trail:• " white space characters to show
