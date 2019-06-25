" Mappings
nnoremap <silent><leader>w :w<CR>
nnoremap <silent><leader>q :q<CR>
nnoremap <silent><leader>e :bd<CR>
nnoremap <silent><leader>a :bp<CR>
nnoremap <silent><leader>d :bn<CR>
nnoremap <silent><leader><leader>s :noh<CR>

" @TODO Move to NERDTreeToggle
nnoremap <silent><leader>t :NERDTreeToggle<CR>
nnoremap <silent><leader>j :NERDTreeFind<CR>

" @TODO Move to CtrlSF
nmap <C-F>f <Plug>CtrlSFPrompt
vmap <C-F>f <Plug>CtrlSFVwordPath

" Reindent the whole file
nnoremap <silent><leader>ri mzgg=G`z
