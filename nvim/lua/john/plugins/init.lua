return{
	'nvim-tree/nvim-web-devicons',
	{
		'windwp/nvim-autopairs',
		init = function ()
			require'nvim-autopairs'.setup()
		end,
	},
	{
		'numToStr/Comment.nvim',
		config = function ()
			require'Comment'.setup()
		end
	}
}
