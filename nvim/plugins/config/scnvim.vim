" Snippets directories
let g:UltiSnipsSnippetDirectories = ['UltiSnips', 'scnvim-data']

au! BufNewFile,BufRead *.sc,*.scd setf supercollider " Add supercollider filetype

" Eval flash
" duration of the highlight
let g:scnvim_eval_flash_duration = 100

" number of flashes. A value of 0 disables this feature.
let g:scnvim_eval_flash_repeats = 1

" Path to the sclang executable
" scnvim will look in some known locations for sclang,
" but if it can't find it use this variable instead
" (also improves startup time slightly)
let g:scnvim_sclang_executable = '/Applications/SuperCollider.app/Contents/MacOS/sclang'

" update rate for server info in status line (seconds)
" (don't set this to low or vim will get slow)
let g:scnvim_statusline_interval = 2

" set this variable if you don't want the "echo args" feature
let g:scnvim_echo_args = 1

" UDP port for (remote) python plugin
let g:scnvim_udp_port = 9670

" set this variable if you don't want any default mappings
let g:scnvim_no_mappings = 1

" configure the color
highlight SCNvimEval guifg=black guibg=#faf33e ctermfg=black ctermbg=white

" create a custom status line for supercollider buffers
function! s:set_sclang_statusline()
  setlocal stl=
  setlocal stl+=%f
  setlocal stl+=%=
  setlocal stl+=%(%l,%c%)
  setlocal stl+=\ \|
  setlocal stl+=%18.18{scnvim#statusline#server_status()}
endfunction

augroup scnvim_stl
  autocmd!
  autocmd FileType supercollider call <SID>set_sclang_statusline()
augroup END

" Mappings
" Send selection
au Filetype supercollider nmap <buffer> <silent><CR> <Plug>(scnvim-send-block)
au Filetype supercollider xmap <buffer> <silent><CR> <Plug>(scnvim-send-selection)

" Toggle window
au Filetype supercollider nmap <buffer> <silent><Space> <Plug>(scnvim-postwindow-toggle)

" Clear window
au Filetype supercollider nmap <buffer> <silent><leader>0 <Plug>(scnvim-postwindow-clear)

" Start Server
au Filetype supercollider nmap <buffer> <F4> :SCNvimStart<CR>

" Reboot Server
au Filetype supercollider nmap <buffer> <F5> :SCNvimRecompile<CR>

" Stop Server
au Filetype supercollider nmap <buffer> <F6> :SCNvimStop<CR>
