inoremap jk <Esc>
noremap <F1> :bp<CR>
noremap <F2> :bn<CR>
noremap <F9> :GoTest<CR>
nmap <C-m>d <Plug>MarkdownPreview
nmap <C-m>s <Plug>MarkdownPreviewStop
nmap <C-m>t <Plug>MarkdownPreviewToggle

set number
set shiftwidth=4
set ts=4
set expandtab
set fo-=t
set hidden

set backspace=indent,eol,start
set laststatus=2
set statusline=%{getcwd()}%=%l:%c

set nrformats+=alpha
set background=dark

colorscheme slate

filetype plugin indent on
syntax enable
syntax on

call plug#begin('~/.vim/plugged/')

Plug 'Yggdroot/indentline'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'machakann/vim-highlightedyank'
let g:highlightedyank_highlight_duration = 250

call plug#end()
