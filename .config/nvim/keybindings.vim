" VIM key bindings

let g:mapleader = "\<Space>"
" Disable useless binding
nmap Q <Nop>
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

"Coc completion
inoremap <silent><expr> <c-space> coc#refresh()

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')


" Move between open windows
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" Move in long wrapped lines
nmap <Down> gj
nmap <Up> gk

" Use arrow keys in visual mode for indenting
vmap <Left> <gv
vmap <Right> >gv

" Addtional escapes
inoremap kj <esc>
" inoremap jk <esc> " Disabled temporarily while working on nunjucks files

" Toggle spellchecking
:map <F6> :setlocal spell! spelllang=en_gb<CR>

" Which key
nnoremap <silent> <leader> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>
let g:which_key_map =  {}


" Single mappings
let g:which_key_map['c'] = [ ':e $MYVIMRC'     , 'search files' ]
let g:which_key_map['f'] = [ ':Files'     , 'search files' ]
let g:which_key_map['S'] = [ ':Startify'  , 'start screen' ]
let g:which_key_map['h'] = [ '<C-W>s'     , 'split below']
let g:which_key_map['v'] = [ '<C-W>v'     , 'split right']
let g:which_key_map['z'] = [ 'Goyo'       , 'zen mode' ]
let g:which_key_map['q'] = [ ':q'         , 'close buffer' ]
let g:which_key_map['p'] = [ ':Format'    , 'Format current file' ]

" s is for search
let g:which_key_map.s = {
      \ 'name' : '+search' ,
      \ '/' : [':History/'     , 'history'],
      \ ';' : [':Commands'     , 'commands'],
      \ 'a' : [':Ag'           , 'text Ag'],
      \ 'b' : [':Buffers'      , 'open buffers'],
      \ 'c' : [':Commits'      , 'commits'],
      \ 'f' : [':Files'        , 'files'],
      \ 'g' : [':GFiles'       , 'git files'],
      \ 'h' : [':Helptags'     , 'help tags'] ,
      \ 'm' : [':Marks'        , 'marks'] ,
      \ 'r' : [':Rg'           , 'text Rg'],
      \ }

" m is for make
let g:which_key_map.m = {
      \ 'name' : '+make' ,
      \ 'm' : [':!make'       , 'make default'],
      \ 'r' : [':make run'   , 'make run'],
      \ 'c' : [':make clean' , 'make clean'],
      \ }

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

" Clear current highlighted text
nnoremap <CR><CR> :noh<CR><CR>

" Register which key map
call which_key#register('<Space>', "g:which_key_map")

" Replace yanked word
nmap <C-p> ciw<C-r>0<ESC>
