set nocompatible

syntax on                     " syntax highlighting

set background=dark
set cursorcolumn
set cursorline                " current line highlight
set expandtab
set history=10000
set hlsearch                  " highlight all search results
set ignorecase                " do case insensitive search
set incsearch                 " show incremental search results as you type
set noswapfile
set number                    " display line number
set re=0
set redrawtime=1000
set relativenumber
set shellcmdflag=-ic
set shiftwidth=4
set showcmd
set smartcase
set tabstop=4
set updatetime=1000

inoremap kj <Esc>
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

autocmd BufNewFile,BufRead *.gitconfig* setlocal filetype=gitconfig
autocmd BufNewFile,BufRead *.gitignore* setlocal filetype=gitignore
autocmd Filetype gitconfig setlocal noexpandtab
autocmd Filetype javascript setlocal ts=2 sw=2 expandtab
autocmd Filetype json setlocal ts=2 sw=2 expandtab
autocmd Filetype sh setlocal ts=2 sw=2 expandtab
autocmd Filetype typescript setlocal ts=2 sw=2 expandtab

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

filetype plugin indent on

runtime macros/matchit.vim

call plug#begin()

Plug 'junegunn/vim-easy-align'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-lastpat'
Plug 'pineapplegiant/spaceduck', { 'branch': 'main' }
Plug 'subnut/visualstar.vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-jdaddy'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'wuelnerdotexe/vim-enfocado'

call plug#end()

if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

colorscheme spaceduck

let g:enfocado_style = 'neon' " Available: `nature` or `neon`
