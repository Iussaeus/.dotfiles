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
			{ "<C-Up>",   "<Cmd>MultipleCursorsAddUp<CR>",            mode = { "n", "i", "x" } },
			{ "<C-Down>", "<Cmd>MultipleCursorsAddDown<CR>",          mode = { "n", "i", "x" } },
			{ "<C-n>",    "<Cmd>MultipleCursorsAddVisualArea<CR>",    mode = { "v" } },
			{ "<C-n>",    "<Cmd>MultipleCursorsAddJumpNextMatch<CR>", mode = { "n", "i" } },
			{ "<C-S-N>",    "<Cmd>MultipleCursorsJumpNextMatch<CR>",    mode = { "n", "i" } },
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
