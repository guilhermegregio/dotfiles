" Make vim more useful {{{
set nocompatible
" }}}

" Syntax highlighting {{{
set t_Co=256
syntax on
" }}}

set backupdir=~/.backup//
set directory=~/.backup//

iab gmg Guilherme Mangabeira Gregio<guilherme@gregio.net>

"......................................................................ARQUIVO
"" Sai fora na marra!
imap <F12> <esc>:wqa!<cr>
map <F12> :wqa!<cr>
" Abreviacoes-uteis para sua sanidade mental
cab W w| cab Q q| cab Wq wq| cab wQ wq| cab WQ wq

" Copy e paste
nmap <F3> :set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
imap <F3> <Esc>:set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
nmap <F2> :.w !pbcopy<CR><CR>
vmap <F2> :w !pbcopy<CR><CR>

hi    Search ctermbg=green ctermfg=black
hi IncSearch ctermbg=black ctermfg=cyan
set is hls ic scs  "opções espertas de busca

set number
set nowrap
set tabstop=4
set shiftwidth=4
set softtabstop=4
set clipboard=unnamed
set laststatus=2
set encoding=utf-8
set guifont=Inconsolata\ for\ Powerline:h15
let g:Powerline_symbols = 'fancy'
set fillchars+=stl:\ ,stlnc:\
set term=xterm-256color
set termencoding=utf-8
set background=dark
set clipboard=unnamedplus
" Macros
let @q='0f,xxd$a</a>0i<a href="pa">j@q'
let @t='_O<tr height="22" valign="top"><td align="left"><font size="2" color="#0b2266" face="arial">jo</font></tr></tr>j_'
let @a='0wwi"f"xf"xf"xf"xf"xf"xf"xf"xf"xf"xf"xf"xj0@a'


" CtrlP Config
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files . -co --exclude-standard|egrep -v "\.(git|svn|jpg|jpeg|png|gif)$"']

" CtrlP Config
map <C-n> :NERDTreeToggle<CR>

" JSBEAUTIFY shorcuts
" for javascript
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
" for html
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
" for css or scss
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>

set rtp+=~/dotfiles/vim/bundle/powerline/powerline/bindings/vim
" Always show statusline
set laststatus=2
" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

" Plugins {{{
filetype off

set rtp+=~/dotfiles/vim/bundle/Vundle.vim
call vundle#begin('~/dotfiles/vim/bundle')
Plugin 'gmarik/Vundle.vim'
" Adicionar outros plugins
" Plugin ''
Plugin 'maksimr/vim-jsbeautify' 
Plugin 'mattn/emmet-vim'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'digitaltoad/vim-jade'
Plugin 'ervandew/supertab'
Plugin 'powerline/powerline'
Plugin 'yosiat/oceanic-next-vim'
Plugin 'altercation/vim-colors-solarized'

call vundle#end()
filetype plugin indent on
" }}}

"colo OceanicNext
