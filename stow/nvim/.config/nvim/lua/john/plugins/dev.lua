return {
	{
		"Iussaeus/ido-mode.nvim",
		dir = (function() return os.getenv("HOME").."/code/ido-mode.nvim" end)(),
		config = function()
			require 'ido-mode'.setup(require'ido-mode.config'.defaults)
		end
	},
}
