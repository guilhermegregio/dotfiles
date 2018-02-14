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

Plug 'maksimr/vim-jsbeautify' 
Plug 'mattn/emmet-vim'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'digitaltoad/vim-jade'
Plug 'ervandew/supertab'
Plug 'powerline/powerline'
Plug 'yosiat/oceanic-next-vim'
Plug 'altercation/vim-colors-solarized'


filetype plugin indent on                   " required!
call plug#end()
