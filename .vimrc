syntax enable

set encoding=UTF-8
let mapleader = " "
set scrolloff=5
set incsearch
set hlsearch
set number
set relativenumber
set tabstop=2
set belloff=all
set visualbell
set noerrorbells
set showmode
set shiftwidth=2

"----------------Mapping-----------------"
map Q gq
map H b
map L e
map J 3j
map K 3k
map <leader>/ :nohl<CR>
map <leader>q :wqa<CR>
map <A-w> :bd<CR>

" Normal Map
nmap <Leader>sp :sp<cr>
nmap <Leader>vsp :vsp<cr>
nmap <C-l> <C-w>l
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <Leader>. <C-w>>


"----------------Auto Command---------------"
autocmd BufWritePost .vimrc source %
