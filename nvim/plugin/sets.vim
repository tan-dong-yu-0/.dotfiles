set relativenumber
set autoindent
set smartcase
set hlsearch
set incsearch
set ignorecase
set confirm
set ruler
set laststatus=2
set cursorline
set title
set background=dark
set nowrap
syntax enable
set expandtab
set shiftwidth=4
set tabstop=4 softtabstop=4
set termguicolors
set scrolloff=8
set cmdheight=1
set updatetime=50
set ts=2 sw=2
set clipboard+=unnamedplus
set splitright
set splitbelow
set noshowmode
" set paste
" set showtabline=2

" set transparent nvim background
au ColorScheme * hi Normal ctermbg=none guibg=NonText
au ColorScheme myspecialcolor hi Normal ctermbg=red guibg=red

" prevent commenting on new line
autocmd FileType * set formatoptions-=o

" turn terminal to normal mode with escape key
" tnoremap <ESC> <C-\><C-n>

" open terminal with ctrl+n
" function! OpenTerminal()
"   split term://bash
"   resize 10
" endfunction
" nnoremap <A-n> :call OpenTerminal()<CR>

" colorscheme(theme)
let g:gruvbox_contrast_dark = "medium"
colorscheme gruvbox
highlight ColorColumn ctermbg=0 guibg=grey
hi SignColumn guibg=none
hi CursorLineNR guibg=None
highlight Normal guibg=none
highlight LineNr guifg=#5eacd3
" highlight netrwDir guifg=#5eacd3
highlight qfFileName guifg=#aed75f

" remove nvimtree

" netrw(file explorer)
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

" use CTRL+{h, j, k, l} to navigate windows 
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" use Alt{j, k} to move lines
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
