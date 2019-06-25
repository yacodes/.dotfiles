" Core configuration
set number " Show line numbers
set clipboard=unnamedplus " Copy to system's clipboard
set title " Set terminal title
set autoread " detect when a file is changed
set autoindent " automatically set indent of new line
set smartindent " smartindent
set showmatch " show matching braces
set history=1000 " change history to 1000
set textwidth=160 " text width before next line
set laststatus=2 " show the satus line all the time
set so=7 " set 7 lines to the cursors - when moving vertical
set wildmenu " enhanced command line completion
set hidden " current buffer can be put into background
set showcmd " show incomplete commands
set noshowmode " don't show which mode disabled for PowerLine
set nowrap " prevent lines from wrapping
set nobackup " prevent creating backup files
set noswapfile " prevent creating swap files
set showtabline=2 " show tabline

" Set gui cursor
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
  \,sm:block-blinkwait175-blinkoff150-blinkon175

" Set theme configuration
set background=dark
set t_Co=256

" Set english UI language
set langmenu=en_US
let $LANG='en_US'

" Tab control
set smarttab " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
set tabstop=2 " the visible width of tabs
set softtabstop=2 " edit as if the tabs are 2 characters wide
set expandtab " use spaces instead of tabs
set shiftwidth=2 " number of spaces to use for indent and unindent

" Searching
set ignorecase " case insensitive searching
set smartcase " case-sensitive if expresson contains a capital letter
set hlsearch " highlight search results
set incsearch " set incremental search, like modern browsers
set nolazyredraw " don't redraw while executing macros

autocmd BufWritePre * :%s/\s\+$//e " Remove trailing whitespaces on save
