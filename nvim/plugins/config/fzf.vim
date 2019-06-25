" Set path to fzf
set rtp+=/usr/local/opt/fzf

" Set default command
let $FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

" Mappings
nnoremap <silent><leader>f :FZF<CR>
