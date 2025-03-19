return {
	{
		'xiyaowong/transparent.nvim',
		lazy = false,
	},
	{
		'Mofiqul/vscode.nvim',
		init = function()
			require('vscode').setup({
				italic_comments = true,
				color_overrides = { vscLineNumber = '#FFFFFF' },
			})
		end,
	},
	{
		"rose-pine/neovim.nvim",
		name = "rose-pine",
		config = function()
			require 'rose-pine'.setup({
				disable_background = false,
			})

			vim.cmd("colorscheme rose-pine-moon")
		end
	},
}
