" ----------------------------------------------------------------------------
"   Plug
" ----------------------------------------------------------------------------

" Install vim-plug if we don't already have it
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'kien/ctrlp.vim'
Plug 'francoiscabrol/ranger.vim'
Plug 'ervandew/supertab'
Plug 'moll/vim-node'
Plug 'wellle/targets.vim'
Plug 'terryma/vim-multiple-cursors'

Plug 'scrooloose/syntastic'
Plug 'maksimr/vim-jsbeautify' 
Plug 'mattn/emmet-vim'
Plug 'digitaltoad/vim-jade'
Plug 'mxw/vim-jsx'
Plug 'ianks/vim-tsx'
Plug 'leafgarland/typescript-vim'
Plug 'pangloss/vim-javascript'
Plug 'elmcast/elm-vim'
Plug 'joukevandermaas/vim-ember-hbs'
Plug 'prettier/vim-prettier', { 'do': 'npm install' }

Plug 'editorconfig/editorconfig-vim'

Plug 'bling/vim-airline'
Plug 'yosiat/oceanic-next-vim'
Plug 'altercation/vim-colors-solarized'
Plug 'dracula/vim', { 'as': 'dracula' }

filetype plugin indent on                   " required!
call plug#end()
