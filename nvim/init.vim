call plug#begin()

" gruvbox
Plug 'morhetz/gruvbox'

" autopair
Plug 'cohama/lexima.vim'

" telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" fugitive
Plug 'tpope/vim-fugitive'

" codi.vim(quokka like, only works in js)
" Plug 'metakirby5/codi.vim'

call plug#end()

lua require ('packer-context')
lua require ('treesitter')
lua require ('lsp')
lua require ('lspcolors')
lua require ('lualinesetup')
lua require ('luasnipsetup')

