return {
<<<<<<< HEAD
  {
    "Iussaeus/ido-mode.nvim",
    dir = os.getenv("HOME") .. "/code/ido-mode.nvim",
    config = function()
      local ido = require 'ido-mode'.setup()
      vim.keymap.set("c", "<cr>", function() ido:enter() end)
      vim.keymap.set("c", "<bs>", function() ido:backspace() end)
      vim.keymap.set("c", "<c-n>", function() ido:next_suggestion() end)
      vim.keymap.set("c", "<c-p>", function() ido:previous_suggestion() end)
      vim.keymap.set("c", "<c-y>", function() ido:accept_suggestion() end)
    end
  },
  {
    "Iussaeus/goback.nvim",
    dir = os.getenv("HOME") .. "/code/goback.nvim",
    config = function()
      local goback = require 'goback'.setup()
      vim.keymap.set("n", "<leader>gb", function() goback:one_level_back() end)
      vim.keymap.set("n", "<leader>gf", function() goback:one_level_forth() end)
    end
  },
=======
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
>>>>>>> 3c7a26e (changed the nvim config)
}
