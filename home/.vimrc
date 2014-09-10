"Vundle Premable
set nocompatible 
filetype off                  " required!
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle
" required! 
Plugin 'gmarik/vundle'
"End Vundle Preamble
"Plugins
Plugin 'flazz/vim-colorschemes'
Plugin 'scrooloose/nerdtree'
"Git integration
Plugin 'tpope/vim-fugitive'
"HTML5
Plugin 'othree/html5.vim'
"Vim JavaScript page recommends
"http://oli.me.uk/2013/06/29/equipping-vim-for-javascript/
Plugin 'jelera/vim-javascript-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'marijnh/tern_for_vim'
"Airline
Plugin 'bling/vim-airline'
Plugin 'edkolev/tmuxline.vim'
"Delimiter Matching
Plugin 'Raimondi/delimitMate'
"Haskell Plugins
Plugin 'laurilehmijoki/haskellmode-vim'
Plugin 'Shougo/vimproc.vim'
Plugin 'Shougo/vimshell.vim'
"Ruby
Plugin 'vim-ruby/vim-ruby'
" Track the engine.
Plugin 'SirVer/ultisnips'
Bundle 'ervandew/supertab'
" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'
call vundle#end()            " required"
"
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

"leader to execute ruby
noremap <leader>rx :!ruby %<CR>
"Airline Powerline fonts
let g:airline_powerline_fonts = 1
"Remap leader to comma
let mapleader = ","
"ColorScheme
colorscheme kolor
set t_Co=256
set guifont=DejaVu\ Sans\ Mono:12
"Not Suck Tips
set laststatus=2 
set ruler 
set showcmd 
set showmode 
set number
"Not Suck Search
set incsearch 
set ignorecase 
set smartcase 
set hlsearch
"Set Indentation
set expandtab
set autoindent
"Remap leader key to Comma
let mapleader=","
"ESFormatter for JS
vnoremap <silent> <leader>es :! esformatter<CR>
noremap <silent> <leader>e :%!esformatter<CR>
"Detect filetypes and load indents
set filetype=on
filetype plugin on
filetype indent on
set bs=indent,eol,start     " Backspace over everything in insert mode"
"Tab defaults
set ai
set ts=4
set sts=4
set et
set sw=4
set textwidth=79
" Mark down file type
au BufRead,BufNewFile *.md set filetype=markdown
" HTML (tab width 2 chr, no wrapping)
autocmd FileType html set sw=2
autocmd FileType html set ts=2
autocmd FileType html set sts=2
autocmd FileType html set textwidth=0
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
" Python (tab width 4 chr, wrap at 79th char)
autocmd FileType python set sw=4
autocmd FileType python set ts=4
autocmd FileType python set sts=4
autocmd FileType python set textwidth=79
autocmd FileType python set omnifunc=pythoncomplete#Complete
" CSS (tab width 2 chr, wrap at 79th char)
autocmd FileType css set sw=2
autocmd FileType css set ts=2
autocmd FileType css set sts=2
autocmd FileType css set textwidth=79
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
" JavaScript (tab width 2 chr, wrap at 79th)
autocmd FileType javascript set sw=2
autocmd FileType javascript set ts=2
autocmd FileType javascript set sts=2
autocmd FileType javascript set textwidth=79
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
" Tab specific option
autocmd FileType haskell set tabstop=8 "A tab is 8 spaces
autocmd FileType haskell set expandtab "Always uses spaces instead of tabs
autocmd FileType haskell set softtabstop=4 "Insert 4 spaces when tab is pressed
autocmd FileType haskell set shiftwidth=4 "An indent is 4 spaces
autocmd FileType haskell set smarttab "Indent instead of tab at start of line
autocmd FileType haskell set shiftround "Round spaces to nearest shiftwidth multiple
autocmd FileType haskell set nojoinspaces "Don't convert spaces to tabs
" use ghc functionality for haskell files
au Bufenter *.hs compiler ghc
let g:haddock_browser = "/usr/bin/firefox"
let g:ghc = "/usr/bin/ghc"
let g:ycm_semantic_triggers = {'haskell' : ['.']}
"YouCompleteMe + Eclim integration?
let g:EclimCompletionMethod = 'omnifunc'

syntax on

