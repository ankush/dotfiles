" NEOVIM CONFIGURATION FILE
call plug#begin($HOME . '/.local/share/nvim/plugged')

" Intelligence
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Appearance
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'dracula/vim', { 'as': 'dracula' }

" HTML/CSS/JS
Plug 'norcalli/nvim-colorizer.lua'
Plug 'mattn/emmet-vim', { 'for': ['html', 'javascript', 'markdown'] }

"Haskell
Plug 'neovimhaskell/haskell-vim'
call plug#end()

let g:mapleader = "\<Space>"
colorscheme dracula
set ruler " Show cursor position all the time
set background=dark
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
set termguicolors
set colorcolumn=80 " Colour column to show 79 char limit
lua require'colorizer'.setup()


" Key mappings
nmap Q <Nop> " Disable useless binding
" Disable arrow keys
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>
" Completion navigation
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")
" Resize windows
nnoremap <M-j>     :resize -2<CR>
nnoremap <M-k>     :resize +2<CR>
nnoremap <M-h>     :vertical resize -2<CR>
nnoremap <M-l>     :vertical resize +2<CR>

" Save like normal human beings
nnoremap <C-s> :w<CR>

" Theme for lightline
let g:lightline = {
    \ 'colorscheme': 'seoul256',
    \}

" Show at least 5 extra lines while scrolling
set scrolloff=5
