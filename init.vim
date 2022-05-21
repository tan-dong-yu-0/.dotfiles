call plug#begin()

" gruvbox
Plug 'morhetz/gruvbox'

" autopair
Plug 'cohama/lexima.vim'

" telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" codi.vim(quokka like plugin for nvim)
Plug 'metakirby5/codi.vim'
call plug#end()

lua require ('packer-context')
lua require ('treesitter')
lua require ('lsp')
