local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'
	use 'nvim-lua/plenary.nvim'
	use	'nvim-tree/nvim-web-devicons'
	-- Telescope
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.5',
		-- or                            , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}
	-- VsCode color theme aka the GOAT
	use 'Mofiqul/vscode.nvim'
	-- Harpoon
	use {
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
	}
	-- Treesitter
	use'nvim-treesitter/nvim-treesitter'
	-- Lsp-Zero(Super Important)
	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		requires = {
			{'williamboman/mason.nvim'},
			{'williamboman/mason-lspconfig.nvim'},
			-- LSP Support
			{'neovim/nvim-lspconfig'},
			-- Autocompletion
			{'hrsh7th/nvim-cmp'},
			{'hrsh7th/cmp-nvim-lsp'},
			{'L3MON4D3/LuaSnip'},
		}
	}
	-- Auto-pairing
	use'windwp/nvim-autopairs'
	-- Comment
	use'numToStr/Comment.nvim'
	-- LuaLine
	use'nvim-lualine/lualine.nvim'
	-- Nvim-tree
	use {
		'nvim-tree/nvim-tree.lua',
		requires = {
			'nvim-tree/nvim-web-devicons', -- optional
		},
	}
	-- Terminal
	use'rebelot/terminal.nvim'
	-- Python virtual enviroment
	use'linux-cultist/venv-selector.nvim'
	-- Dressing ( for better input ui )
	use {'stevearc/dressing.nvim'}
end)
