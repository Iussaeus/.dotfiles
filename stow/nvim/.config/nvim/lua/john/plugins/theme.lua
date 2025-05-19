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
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require 'rose-pine'.setup({
				enable = {
					terminal = true,
				},
				styles = {
					bold = true,
					italic = true,
					-- transparency = false,
				},
				palette = {
					moon = {
					    base = '#101010',
					    overlay = '#363738',
					},
				},
			})

			vim.cmd("colorscheme rose-pine-moon")
		end
	},
}
