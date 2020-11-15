" NEOVIM CONFIGURATION FILE
source $HOME/.config/nvim/plugins.vim
source $HOME/.config/nvim/keybindings.vim

colorscheme dracula
filetype plugin indent on
set backspace=indent,eol,start " Disable awkward backspace behaviour
set clipboard=unnamedplus  " Use the system clipboard by default
set cursorline " highlight current line
set encoding=utf-8
set expandtab
set fileencoding=utf-8
set fileencodings=utf-8
set hidden " Allows hiding unsaved buffers
set history=1000
set ignorecase " Ignore case while searching
set inccommand=nosplit
set incsearch " Search while still typing
set laststatus=2  " Always show the status line at the bottom
set lazyredraw " Don't redraw when running macros
set list
set listchars=tab:│>-,extends:>,precedes:<,nbsp:⦸
set mouse+=a " Enable mouse support
set nojoinspaces  " Use one space, not two, after punctuation
set nomodeline " Disable modlines
set noswapfile  " Don't use a swapfile for the buffer
set nowritebackup " required by Coc
set number " show absolute line number on current line
set numberwidth=6
set relativenumber " show relative line number on all other lines
set scrolloff=5 " Show at least 5 extra lines while scrolling
set shiftwidth=4
set shortmess+=I " Disable the default Vim startup message.
set shortmess+=W " Disable file written messages
set showtabline=2 " Enable bufferline on top
set smartcase " Consider case if caps are present
set softtabstop=0
set spellfile=$HOME/.config/nvim/spell/en.utf-8.add
set spelllang=en_gb " enable spell-check
set splitbelow " Open new window in bottom half
set splitright " Open new window in right half
set tabstop=4
set timeoutlen=500 " reduce leader key timeout from 1sec to 0.5
set updatetime=150
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro
" Trim whitespace on save for all files
autocmd BufWritePre * :%s/\s\+$//e

" When editing a file, always jump to the last known cursor position.
" Don't do it for commit messages, when the position is invalid, or when
" inside an event handler (happens when dropping a file on gvim).
autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
