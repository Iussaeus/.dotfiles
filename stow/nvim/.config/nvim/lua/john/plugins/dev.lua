return {
	{
		"ido-mode",
		dir = "/home/john/code/ido-mode.nvim/",
		config = function()
			local ido = require 'ido-mode'.setup()
			vim.keymap.set("c", "<cr>",  function() ido:enter() end)
			vim.keymap.set("c", "<bs>",  function() ido:backspace() end)
			vim.keymap.set("c", "<c-n>", function() ido:next_suggestion() end)
			vim.keymap.set("c", "<c-p>", function() ido:previous_suggestion() end)
			vim.keymap.set("c", "<c-y>", function() ido:accept_suggestion() end)
		end
	},
}
