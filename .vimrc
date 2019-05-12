" vim-plug
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'ajh17/VimCompletesMe'
call plug#end()

" vim-powerline
set  rtp+=~/.local/lib/python3.7/site-packages/powerline/bindings/vim/
set laststatus=2
set t_Co=256

" NERDTree toggle
map <C-n> :NERDTreeToggle<CR>

" conf
set nocompatible
filetype plugin on
syntax on
set encoding=utf-8
set number relativenumber

vnoremap <C-c> y <CR> :call system("xclip -selection clipboard", @0) <CR>   
