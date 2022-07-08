return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'windwp/nvim-ts-autotag' }

  -- lspconfig
  use 'neovim/nvim-lspconfig'
  use 'L3MON4D3/LuaSnip'
  use 'hrsh7th/nvim-cmp'
  use 'saadparwaiz1/cmp_luasnip'
  use { 'tzachar/cmp-tabnine', run = './install.sh', requires = 'hrsh7th/nvim-cmp' }
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'onsails/lspkind.nvim'
  use 'williamboman/nvim-lsp-installer'
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'folke/lsp-colors.nvim'

  -- Comment nvim
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }


  -- Snippets
  use 'rafamadriz/friendly-snippets'

  -- nvim autopairs
  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }

  -- gitsigns
  use { 'lewis6991/gitsigns.nvim' }

  -- popup nvim
  use { "nvim-lua/popup.nvim" }

  -- Lualine
  use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }
end)
