" Mappings
nnoremap <silent><leader>w :w<CR>
nnoremap <silent><leader>q :q<CR>
nnoremap <silent><leader>e :bd<CR>
nnoremap <silent><leader>a :bp<CR>
nnoremap <silent><leader>d :bn<CR>
nnoremap <silent><leader><leader>s :noh<CR>

" @TODO Move to CtrlSF
nmap <C-F>f <Plug>CtrlSFPrompt
vmap <C-F>f <Plug>CtrlSFVwordPath

" Reindent the whole file
nnoremap <silent><leader>ri mzgg=G`z

" [] + <Space>
function! s:BlankUp(count) abort
  put!=repeat(nr2char(10), a:count)
  ']+1
  silent! call repeat#set("\<Plug>unimpairedBlankUp", a:count)
endfunction

function! s:BlankDown(count) abort
  put =repeat(nr2char(10), a:count)
  '[-1
  silent! call repeat#set("\<Plug>unimpairedBlankDown", a:count)
endfunction

nnoremap <silent> [<Space> :call <SID>BlankUp(v:count1)<CR>
nnoremap <silent> ]<Space> :call <SID>BlankDown(v:count1)<CR>
