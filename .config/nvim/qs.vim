set nu
set relativenumber

set nocp
filetype plugin off

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set smartindent

set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

set nohlsearch
set incsearch

set scrolloff=8
set signcolumn=yes
set isfname+=@-@

set updatetime=50

set colorcolumn=120
let mapleader = " "

nn <leader>bw :set textwidth=80<CR>:set colorcolumn=80<CR>
nn <leader>bn :set textwidth=0<CR>:set colorcolumn=120<CR>

nn <leader>. :Ex<CR>
vn J :m '>+1<CR>gv=gv
vn K :m '<-2<CR>gv=gv
nn <leader>ga :!git add "%"<CR><CR>
nn <leader>gs :!git status<CR>
nn <leader>gc :!git commit -m '
nn <leader>fs :w<CR>
nn <leader>np :e pnotes/<C-r>=tolower(trim(system('uuidgen')))<CR>.md<CR>
nn <leader>nf :e fnotes/<C-r>=tolower(trim(system('uuidgen')))<CR>.md<CR>
nn <leader>nl :e lnotes/<C-r>=tolower(trim(system('uuidgen')))<CR>.md<CR>
nn <leader>nr :e rnotes/<C-r>=tolower(trim(system('uuidgen')))<CR>.md<CR>
nn <leader>nj :e journal/<C-r>=trim(system('date +%F'))<CR>.md<CR>
nn <leader>nd :e daily/<C-r>=trim(system('date +%F'))<CR>.md<CR>
nn <leader>ns :e session/<C-r>=trim(system('date +%F'))<CR>--.md<Left><Left><Left>
nn <leader>nw :e prose/<C-r>=trim(system('date +%F'))<CR>--.md<Left><Left><Left>
nn <leader>ni :let ff=filter(readdir('fnotes'), 'v:val =~ "\.md"')<CR>:e fnotes/<C-r>=ff[rand() % len(ff)]<CR><CR>
nn <leader>ne :let ff=filter(readdir('pnotes'), 'v:val =~ "\.md"')<CR>:e pnotes/<C-r>=ff[rand() % len(ff)]<CR><CR>
nn <leader>na :!mv % archive<CR><CR>:e archive/<C-r>=expand('%:t')<CR><CR>
nn <leader>nu :!mv % lnotes<CR><CR>:e lnotes/<C-r>=expand('%:t')<CR><CR>
nn <leader>ii i<C-r>=strftime("%FT%T%z")<CR><ESC>
vn <leader>ii c<C-r>=strftime("%FT%T%z")<CR><ESC>
vn <leader>lf :s/\s*$\s*/<C-k>DE$<C-k>DE/<CR>gv:!column -ts <C-k>DE<CR><ESC>
vn <leader>cfa :s/\s*=\s*/<C-k>DE=<C-k>DE/<CR>gv:!column -ts <C-k>DE<CR><ESC>
vn <leader>cfm :s/\s*\(\S\+\)$/<C-k>DE\1/<CR>gv:!column -ts <C-k>DE<CR><ESC>
vn <leader>cfd :!column -t<CR>gv=
