if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.local/share/nvim/plugged')
Plug 'tpope/vim-sensible'
Plug 'flazz/vim-colorschemes'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'jiangmiao/auto-pairs'
Plug 'elzr/vim-json'
call plug#end()

colorscheme Tomorrow-Night-Eighties
set sw=2 "Shift width, >>"
set ts=2 "Tab stop"
set sts=2 "Soft Tab Stop"
set et "expand tabs"
set textwidth=79

