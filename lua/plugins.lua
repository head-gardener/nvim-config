require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'tpope/vim-commentary'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' }
  }
  use {
    'romgrk/barbar.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' }
  }
  use 'srstevenson/vim-picker'

  -- themes
  use 'ellisonleao/gruvbox.nvim'
  use { 'shaunsingh/oxocarbon.nvim', run = "./install.sh" }
  use 'AlessandroYorba/Sierra'

  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'

  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/cmp-vsnip'

  use 'nvim-tree/nvim-tree.lua'

  use 'nvim-treesitter/nvim-treesitter'

  use 'psliwka/vim-smoothie'
  use 'tpope/vim-endwise'
  use 'tpope/vim-surround'
  use 'windwp/nvim-autopairs'
end)
