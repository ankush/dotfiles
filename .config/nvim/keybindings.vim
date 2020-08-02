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

nmap <Leader>1 <Plug>lightline#bufferline#go(1)
nmap <Leader>2 <Plug>lightline#bufferline#go(2)
nmap <Leader>3 <Plug>lightline#bufferline#go(3)
nmap <Leader>4 <Plug>lightline#bufferline#go(4)
nmap <Leader>5 <Plug>lightline#bufferline#go(5)
nmap <Leader>6 <Plug>lightline#bufferline#go(6)

nmap <Leader>c1 <Plug>lightline#bufferline#delete(1)
nmap <Leader>c2 <Plug>lightline#bufferline#delete(2)
nmap <Leader>c3 <Plug>lightline#bufferline#delete(3)
nmap <Leader>c4 <Plug>lightline#bufferline#delete(4)
nmap <Leader>c5 <Plug>lightline#bufferline#delete(5)
nmap <Leader>c6 <Plug>lightline#bufferline#delete(6)
