return {
	{
		'xiyaowong/transparent.nvim',
		lazy = false,
	},
	{
		'Mofiqul/vscode.nvim',
		init = function()
			local c = require 'vscode.colors'.get_colors()
			require('vscode').setup({
				transparent = true,
				italic_comments = true,
				underline_links = true,
				disable_nvimtree_bg = true,
				terminal_colors = true,
				color_overrides = {
					vscLineNumber = '#FFFFFF',
				},
				group_overrides = {
					Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
				}
			})
			vim.opt.list = true
			vim.cmd.colorscheme 'vscode'
			vim.opt.listchars = { tab = '▸ ', lead = '•', trail = '•', eol = '↵' }
			vim.cmd('highlight whitespace ctermfg=darkgrey guifg=#505050')
			vim.cmd('highlight nontext ctermfg=darkgrey guifg=#909090')
		end,
	},
	-- {
	-- 	"rose-pine/neovim",
	-- 	name = "rose-pine",
	-- 	config = function()
	-- 		require 'rose-pine'.setup({
	-- 			enable = {
	-- 				terminal = true,
	-- 			},
	-- 			styles = {
	-- 				bold = true,
	-- 				italic = true,
	-- 				transparency = true,
	-- 			},
	-- 			palette = {
	-- 				moon = {
	-- 					base = '#101010',
	-- 					overlay = '#363738',
	-- 				},
	-- 			},
	-- 		})
	-- vim.cmd.colorscheme 'rose-pine-moon'
	-- 	end
	-- },
}
