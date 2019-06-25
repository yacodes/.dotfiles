" Plug Begin
call plug#begin('~/.config/nvim/plugged')

" Extensions
Plug 'chriskempson/base16-vim' " Colorscheme
Plug 'mhinz/vim-startify' " Custom start screen
Plug 'itchyny/lightline.vim' " Statusline
Plug 'mengelbrecht/lightline-bufferline' " Bufferline
Plug 'Raimondi/delimitMate' " Autoclose of quotes, parenthesis, brackets, etc.
Plug 'kien/rainbow_parentheses.vim' " Rainbow parenthesis
Plug 'scrooloose/nerdcommenter' " Comments shortcuts
Plug 'vim-scripts/matchit.zip' " Extended % matching
Plug 'junegunn/fzf', {'on': ['FZF'], 'dir': '~/.fzf', 'do': './install --all'} " Fuzzy file finder
Plug 'tpope/vim-fugitive' " Git wrapper
Plug 'dyng/ctrlsf.vim', {'on': ['CtrlSF']} " File search
Plug 'scrooloose/nerdtree', {'on': ['NERDTreeToggle', 'NERDTreeFind']} " Filetree
Plug 'editorconfig/editorconfig-vim' " .editorconfig support
Plug 'SirVer/ultisnips', {'for': ['supercollider']} " Snippets
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'} " Autocompletions

" Syntax
Plug 'lambdatoast/elm.vim', {'for': 'elm'} " Elm
Plug 'hhsnopek/vim-sugarss', {'for': 'sugarss'} " Sugarss
Plug 'pangloss/vim-javascript', {'for': ['jsx', 'javascript']} " JS
Plug 'mxw/vim-jsx', {'for': ['jsx', 'javascript']} " JSX
Plug 'hail2u/vim-css3-syntax', {'for': 'css'} " CSS3
Plug 'othree/html5.vim', {'for': 'html'} " HTML5
Plug 'tidalcycles/vim-tidal', {'for': 'tidal'} " Tidal
Plug 'carlitux/deoplete-ternjs', {'for': ['jsx', 'javascript'], 'do': 'yarn global add tern'}
Plug 'davidgranstrom/scnvim', {'for': 'supercollider'}
Plug 'neovimhaskell/haskell-vim', {'for': 'haskell'}

call plug#end()

" Plugins configuration files
source ~/.dotfiles/nvim/plugins/config/theme.vim
source ~/.dotfiles/nvim/plugins/config/deoplete.vim
source ~/.dotfiles/nvim/plugins/config/nerdtree.vim
source ~/.dotfiles/nvim/plugins/config/lightline.vim
source ~/.dotfiles/nvim/plugins/config/fzf.vim
source ~/.dotfiles/nvim/plugins/config/vim-jsx.vim
source ~/.dotfiles/nvim/plugins/config/vim-javascript.vim
source ~/.dotfiles/nvim/plugins/config/rainbow_parentheses.vim
source ~/.dotfiles/nvim/plugins/config/deoplete-ternjs.vim
source ~/.dotfiles/nvim/plugins/config/vim-tidal.vim
source ~/.dotfiles/nvim/plugins/config/html5.vim
source ~/.dotfiles/nvim/plugins/config/scnvim.vim