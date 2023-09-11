vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Post-install/update hook with neovim command
  use ({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })

  -- You can alias plugin names
  use ({'dracula/vim', as = 'dracula',config = function() vim.cmd("colorscheme dracula") end})

   use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.2',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use 'nvim-tree/nvim-tree.lua'
  use 'nvim-tree/nvim-web-devicons'
  use "lukas-reineke/indent-blankline.nvim"

end)
