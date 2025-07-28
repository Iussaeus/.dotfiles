return {
	{
		"ido-mode",
		dir = "/home/john/code/ido-mode.nvim/",
		config = function()
			require 'ido-mode'.setup({ min_chars = 2 })
		end
	},
}
