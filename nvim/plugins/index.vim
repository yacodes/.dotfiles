" Plug Begin
call plug#begin('~/.config/nvim/plugged')

" Extensions
Plug 'chriskempson/base16-vim' " Colorscheme
Plug 'mhinz/vim-startify' " Custom start screen
Plug 'Raimondi/delimitMate' " Autoclose of quotes, parenthesis, brackets, etc.
Plug 'luochen1990/rainbow' " Rainbow braces matching
Plug 'scrooloose/nerdcommenter' " Comments shortcuts
Plug 'vim-scripts/matchit.zip' " Extended % matching
Plug 'junegunn/fzf', {'on': ['FZF'], 'dir': '~/.fzf', 'do': './install --all'} " Fuzzy file finder
Plug 'tpope/vim-fugitive' " Git wrapper
Plug 'dyng/ctrlsf.vim' " File search
Plug 'scrooloose/nerdtree', {'on': ['NERDTreeToggle', 'NERDTreeFind']} " Filetree
Plug 'editorconfig/editorconfig-vim' " .editorconfig support
Plug 'junegunn/goyo.vim', {'on': ['Goyo']} " Distraction free writing
Plug 'prettier/vim-prettier', {'do': 'yarn install'} " Clean JS code
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
Plug 'itchyny/lightline.vim' " Statusline
  Plug 'mengelbrecht/lightline-bufferline' " Bufferline

" Syntax
Plug 'leafgarland/typescript-vim', {'for': ['typescript', 'typescriptreact']} " Typescript
Plug 'peitalin/vim-jsx-typescript', {'for': ['typescript', 'typescriptreact']} " Typescript
Plug 'lambdatoast/elm.vim', {'for': 'elm'} " Elm
Plug 'hhsnopek/vim-sugarss', {'for': 'sugarss'} " Sugarss
Plug 'pangloss/vim-javascript', {'for': ['jsx', 'javascript']} " JS
Plug 'mxw/vim-jsx', {'for': ['jsx', 'javascript']} " JSX
Plug 'hail2u/vim-css3-syntax', {'for': 'css'} " CSS3
Plug 'othree/html5.vim', {'for': 'html'} " HTML5
Plug 'tidalcycles/vim-tidal', {'for': 'tidal'} " Tidal
Plug 'davidgranstrom/scnvim', {'for': 'supercollider', 'do': ':UpdateRemotePlugins'}
Plug 'neovimhaskell/haskell-vim', {'for': 'haskell'}
Plug 'sophacles/vim-processing', {'for': 'processing'}
Plug 'evanleck/vim-svelte'

call plug#end()

" Plugins configuration files
source ~/.dotfiles/nvim/plugins/config/theme.vim
source ~/.dotfiles/nvim/plugins/config/nerdtree.vim
source ~/.dotfiles/nvim/plugins/config/lightline.vim
source ~/.dotfiles/nvim/plugins/config/fzf.vim
source ~/.dotfiles/nvim/plugins/config/vim-jsx.vim
source ~/.dotfiles/nvim/plugins/config/vim-javascript.vim
source ~/.dotfiles/nvim/plugins/config/vim-tidal.vim
source ~/.dotfiles/nvim/plugins/config/html5.vim
source ~/.dotfiles/nvim/plugins/config/scnvim.vim
source ~/.dotfiles/nvim/plugins/config/rainbow.vim
source ~/.dotfiles/nvim/plugins/config/ultisnips.vim
source ~/.dotfiles/nvim/plugins/config/supertab.vim
source ~/.dotfiles/nvim/plugins/config/deoplete.vim
source ~/.dotfiles/nvim/plugins/config/vim-prettier.vim
