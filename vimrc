set directory=$HOME/.vim/swapfiles//
set background=dark
set t_Co=256

syntax on
colorschem distinguished

set expandtab
set shiftwidth=2
set softtabstop=2
set autoindent

" temporary, while i get used to folding
augroup personal#ruby
  autocmd!
  autocmd FileType ruby setlocal foldlevel=2 foldmethod=syntax
augroup end

augroup personal#go
  autocmd!
  autocmd FileType go setlocal expandtab! shiftwidth=8 softtabstop=8
augroup end

augroup personal#python
  autocmd!
  autocmd FileType python setlocal expandtab! shiftwidth=8 softtabstop=8
augroup end

" mappings
noremap <C-x> :w<cr>
inoremap <C-x> <esc>:w<cr>a
noremap ; :

" syntax specific bindings
let g:jsonnet_fmt_on_save=0
augroup personal#jsonnet
  autocmd!
  autocmd FileType jsonnet noremap <buffer> <leader>F :w<cr>:%!jsonnet fmt -n 2 -<cr><cr>
augroup end

" fzf integration
set rtp+=~/.fzf
noremap <C-p> :FZF<Enter>

" recognize qsc files
augroup personal#qs
  autocmd!
  autocmd BufNewFile,BufRead *.qsc  set syntax=coffee
  autocmd BufNewFile,BufRead *.jhaml set syntax=haml
  autocmd BufNewFile,BufRead *.avsc set syntax=json
augroup end

" use our wrapper around ack to only look at project files
let g:ackprg = "~/bin/cack"

function! RemoveTrailingWhitespace()
  let l:save = winsaveview()
  %s/ \+$//e
  call winrestview(l:save)
endfunction

function! ToggleColumnColor()
  if !exists("b:EnableColorColumn")
    let b:EnableColorColumn=1
  else
    let b:EnableColorColumn = !b:EnableColorColumn
  endif
  let &colorcolumn=b:EnableColorColumn*80
endfunction


hi ColorColumn ctermbg=darkgray guibg=darkgray
noremap <Leader>W :call RemoveTrailingWhitespace()<cr>
noremap <Leader>C :call ToggleColumnColor()<cr>

" Crypto (via Enchive)
map <Leader>pe :'<,'>!enchive archive \| base64<CR>
map <Leader>pd :'<,'>!base64 -d \| enchive --agent extract<CR>

command! E Explore
command! V Vexplore
command! S Sexplore

" nnoremap <C-J> <C-W><C-J>
" nnoremap <C-K> <C-W><C-K>
" nnoremap <C-L> <C-W><C-L>
" nnoremap <C-H> <C-W><C-H>

execute pathogen#infect()

