syntax on                     " syntax highlighting
set hlsearch                  " highlight all search results
" set ignorecase                " do case insensitive search
set incsearch                 " show incremental search results as you type
set number                    " display line number
set relativenumber
set noswapfile
set tabstop=4
set shiftwidth=4
set expandtab
set cursorline                " current line highlight
set cursorcolumn
set noro
set updatetime=1000
set redrawtime=1000
set re=0
set background=dark
set termguicolors
set showcmd
inoremap kj <Esc>
autocmd Filetype javascript setlocal ts=2 sw=2 expandtab
autocmd Filetype typescript setlocal ts=2 sw=2 expandtab
autocmd Filetype json setlocal ts=2 sw=2 expandtab
autocmd Filetype sh setlocal ts=2 sw=2 expandtab
autocmd BufNewFile,BufRead *.gitconfig* setlocal filetype=gitconfig
autocmd Filetype gitconfig setlocal noexpandtab
autocmd BufNewFile,BufRead *.gitignore* setlocal filetype=gitignore

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'wuelnerdotexe/vim-enfocado'
Plug 'haishanh/night-owl.vim'
Plug 'pineapplegiant/spaceduck', { 'branch': 'main' }
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-fugitive'

call plug#end()

colorscheme spaceduck
let g:enfocado_style = 'neon' " Available: `nature` or `neon`
