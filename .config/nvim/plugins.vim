" Vim-PLugged configuration
call plug#begin($HOME . '/.local/share/nvim/plugged')

" Intelligence
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" General
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

" Appearance
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'sheerun/vim-polyglot'
Plug 'ryanoasis/vim-devicons'

" HTML/CSS/JS
Plug 'norcalli/nvim-colorizer.lua'
Plug 'mattn/emmet-vim', { 'for': ['html', 'javascript'] }

"Haskell
Plug 'neovimhaskell/haskell-vim'

" Git
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

" Plain text
Plug 'vimwiki/vimwiki'

call plug#end()

set termguicolors
lua require'colorizer'.setup()

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

" Theme for lightline
let g:lightline = {
      \ 'colorscheme': 'darcula',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction'
      \ },
      \ 'tabline': {
      \   'left': [ ['buffers'] ],
      \   'right': [ ['close'] ]
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers'
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel'
      \ }
      \ }
let g:lightline#bufferline#enable_devicons = 1
let g:lightline#bufferline#show_number=2
" Signify settings

let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '_'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change            = '~'
let g:signify_sign_show_count = 0
let g:signify_sign_show_text = 1
