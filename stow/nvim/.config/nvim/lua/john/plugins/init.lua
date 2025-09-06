return {
	{
		'windwp/nvim-autopairs',
		opts = {
			map_bs = false,
			map_c_h = false, -- map <C-h> key to delete a pair
			map_c_w = false, -- map <C-w> to delete a pair
		},
	},
	{
		'numToStr/Comment.nvim',
		config = function()
			require 'Comment'.setup()
		end
	},
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({ keymaps = { normal = "s" } })
		end
	},
	{
		'folke/todo-comments.nvim',
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require 'todo-comments'.setup()
			vim.keymap.set("n", "<leader>tdf", "<cmd>TodoTelescope<cr>")
			vim.keymap.set("n", "<leader>tdl", "<cmd>TodoLocList<cr>")
		end
	},
	{
		'MeanderingProgrammer/render-markdown.nvim',
		dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
		opts = {},
		ft = { 'markdown', 'quarto' },
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "markdown",
				callback = function()
					vim.opt_local.formatoptions:append("r")
					vim.opt_local.comments = {
						"b:- [ ]",
						"b:-",
					}
				end,
			})
		end
	},
	{
		"mbbill/undotree",
		init = function() vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle) end
	},
	{
		"chrisgrieser/nvim-spider",
		opts = {
			skipInsignificantPunctuation = false,
		},
		keys = {
			{ "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" } },
			{ "e", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" } },
			{ "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" } },
		},
	},
}
