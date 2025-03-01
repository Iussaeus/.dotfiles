return {
	'nvim-tree/nvim-web-devicons',
	{
		'windwp/nvim-autopairs',
		init = function()
			require 'nvim-autopairs'.setup()
		end,
	},
	{
		'numToStr/Comment.nvim',
		config = function()
			require 'Comment'.setup()
		end
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end
	},
	{
		'folke/todo-comments.nvim',
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local todo = require 'todo-comments'

			todo.setup()

			vim.keymap.set("n", "<leader>tdf", ":TodoTelescope<CR>")
			vim.keymap.set("n", "<leader>tdl", ":TodoLocList<CR>")
			vim.keymap.set("n", "<leader>tdn", function() todo.jump_next() end)
			vim.keymap.set("n", "<leader>tdp", function() todo.jump_prev() end)
		end
	},
	{
		"brenton-leighton/multiple-cursors.nvim",
		version = "*", -- Use the latest tagged version
		opts = {},   -- This causes the plugin setup function to be called
		keys = {
			{ "<C-Up>",   "<Cmd>MultipleCursorsAddUp<CR>",            mode = { "n", "i", "x" }, desc = "Add cursor and move up" },
			{ "<C-Down>", "<Cmd>MultipleCursorsAddDown<CR>",          mode = { "n", "i", "x" }, desc = "Add cursor and move down" },
			{ "<C-n>",    "<Cmd>MultipleCursorsAddVisualArea<CR>",    mode = { "v" },           desc = "Add cursors to the lines of the visual area" },
			{ "<C-n>",    "<Cmd>MultipleCursorsAddJumpNextMatch<CR>", mode = { "n", "i" },      desc = "Add cursors to cword" },
		},
	},
	{
		'Groveer/plantuml.nvim',
		version = '*',
		opts = {
			-- renderer = 'text',
		}
	}
}
