" Add tidal filetype
au! BufNewFile,BufRead *.tidal setf tidal

" Disable default mappings
let g:tidal_no_mappings = 1

" Tmux config
let g:tidal_default_config = {"socket_name": "default", "target_pane": "tidal:0.2"}

" Hush
au Filetype tidal nmap <buffer> <F12> :TidalHush<CR>

" highlight operators
autocmd BufEnter *.tidal highlight Operator ctermfg=13
autocmd BufLeave *.tidal highlight Operator ctermfg=07

" Channels hush mappings
au Filetype tidal nmap <buffer> <F1> :TidalSilence 1<CR>
au Filetype tidal nmap <buffer> <F2> :TidalSilence 2<CR>
au Filetype tidal nmap <buffer> <F3> :TidalSilence 3<CR>
au Filetype tidal nmap <buffer> <F4> :TidalSilence 4<CR>
au Filetype tidal nmap <buffer> <F5> :TidalSilence 5<CR>
au Filetype tidal nmap <buffer> <F6> :TidalSilence 6<CR>
au Filetype tidal nmap <buffer> <F7> :TidalSilence 7<CR>
au Filetype tidal nmap <buffer> <F8> :TidalSilence 8<CR>

" Tidal Send
au Filetype tidal nmap <buffer> <CR> mavip :TidalSend<CR>`a
