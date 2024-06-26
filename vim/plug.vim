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

Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'francoiscabrol/ranger.vim'
Plug 'scrooloose/nerdtree'

Plug 'ervandew/supertab'
Plug 'wellle/targets.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'schickling/vim-bufonly'

Plug 'scrooloose/syntastic'
Plug 'ternjs/tern_for_vim'

Plug 'ludovicchabant/vim-gutentags'

Plug 'tpope/vim-surround'

Plug 'moll/vim-node'
Plug 'tomarrell/vim-npr'

Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'

Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
Plug 'iamcco/coc-tailwindcss',  {'do': 'yarn install --frozen-lockfile && yarn run build'}
Plug 'neoclide/coc-tsserver',  {'do': 'yarn install --frozen-lockfile'}

Plug 'mattn/emmet-vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'joukevandermaas/vim-ember-hbs'
Plug 'chase/vim-ansible-yaml'

Plug 'elmcast/elm-vim'

Plug 'vimwiki/vimwiki'
Plug 'PratikBhusal/vim-grip'
Plug 'dhruvasagar/vim-table-mode'
Plug 'dpelle/vim-LanguageTool'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }

Plug 'prettier/vim-prettier', { 'do': 'npm install' }
Plug 'sbdchd/neoformat'
Plug 'editorconfig/editorconfig-vim'
Plug 'w0rp/ale'

Plug 'bling/vim-airline'
Plug 'bling/vim-bufferline'
Plug 'dracula/vim', { 'as': 'dracula' }

filetype plugin indent on                   " required!
call plug#end()
