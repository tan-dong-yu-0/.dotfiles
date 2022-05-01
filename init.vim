call plug#begin()

" gruvbox
Plug 'morhetz/gruvbox'

" autopair
Plug 'cohama/lexima.vim'

" telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

call plug#end()

lua require ('packer-context')
lua require ('treesitter')
