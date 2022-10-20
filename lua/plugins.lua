require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'tpope/vim-commentary'
	use {
		'nvim-lualine/lualine.nvim',
		requires = {'kyazdani42/nvim-web-devicons'}
	}
	use {
		'romgrk/barbar.nvim',
		requires = {'kyazdani42/nvim-web-devicons'}
	}
	use 'srstevenson/vim-picker'

	use 'ellisonleao/gruvbox.nvim'

	use 'neovim/nvim-lspconfig'

	use 'tpope/vim-projectionist'

  use 'psliwka/vim-smoothie'
	use 'tpope/vim-endwise'
	use 'tpope/vim-surround'
	use 'windwp/nvim-autopairs'
end)

