" vim-plug
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'ycm-core/YouCompleteMe'
Plug 'vim-scripts/ZoomWin'
Plug 'mbbill/undotree'
call plug#end()

" fzf
map <C-p> :GFiles <CR>
map <C-f> :FZF <CR>

" vim-powerline
set  rtp+=~/.local/lib/python3.7/site-packages/powerline/bindings/vim/
set laststatus=2
set t_Co=256

" NERDTree toggle
map <C-n> :NERDTreeToggle<CR>

" colors
colorscheme gruvbox
set background=dark

" conf
set nocompatible
filetype plugin on
syntax on
set encoding=utf-8
set number relativenumber
set hlsearch
set incsearch
set expandtab
set tabstop=4 softtabstop=4
set shiftwidth=4
set smartindent
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set mouse=a

" custom maps
let mapleader = " "

nnoremap <leader>p :tabp<CR>
nnoremap <leader>n :tabn<CR>

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>gd :YcmCompleter GoTo<CR>

vnoremap <C-c> y <CR> :call system("xclip -selection clipboard", @0) <CR>   
