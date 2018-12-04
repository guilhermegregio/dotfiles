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
Plug 'scrooloose/nerdtree'

Plug 'ervandew/supertab'
Plug 'wellle/targets.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'jeffkreeftmeijer/vim-numbertoggle'

Plug 'scrooloose/syntastic'
Plug 'ternjs/tern_for_vim' 

Plug 'tpope/vim-surround'

Plug 'moll/vim-node'

Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'

Plug 'mattn/emmet-vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'joukevandermaas/vim-ember-hbs'

Plug 'elmcast/elm-vim'

Plug 'iamcco/markdown-preview.vim'

Plug 'prettier/vim-prettier', { 'do': 'npm install' }
Plug 'sbdchd/neoformat'
Plug 'editorconfig/editorconfig-vim'
Plug 'w0rp/ale'

Plug 'bling/vim-airline'
Plug 'bling/vim-bufferline'
Plug 'dracula/vim', { 'as': 'dracula' }

filetype plugin indent on                   " required!
call plug#end()
