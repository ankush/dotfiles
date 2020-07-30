" VIM key bindings

let g:mapleader = "\<Space>"
" Key mappings
nmap Q <Nop> " Disable useless binding
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

:nmap <space>e :CocCommand explorer<CR>
