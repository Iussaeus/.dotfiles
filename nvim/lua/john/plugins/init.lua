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
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end
	},
	{
		'folke/todo-comments.nvim',
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local todo = require 'todo-comments'

			todo.setup()

			vim.keymap.set("n", "<leader>tdf", "<cmd>TodoTelescope<cr>")
			vim.keymap.set("n", "<leader>tdl", "<cmd>TodoLocList<cr>")
		end
	},
	{
		"brenton-leighton/multiple-cursors.nvim",
		version = "*",
		opts = {},
		keys = {
			{ "<C-Up>",   "<cmd>MultipleCursorsAddUp<cr>",            mode = { "n", "i", "x" } },
			{ "<C-Down>", "<cmd>MultipleCursorsAddDown<cr>",          mode = { "n", "i", "x" } },
			{ "<C-n>",    "<cmd>MultipleCursorsAddVisualArea<cr>",    mode = { "v" } },
			{ "<C-n>",    "<cmd>MultipleCursorsAddJumpNextMatch<cr>", mode = { "n", "i" } },
			{ "<C-S-N>",  "<cmd>MultipleCursorsJumpNextMatch<cr>",    mode = { "n", "i" } },
		},
	},
	{
		'MeanderingProgrammer/render-markdown.nvim',
		dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
		opts = {},
		---@module 'render-markdown'
		---@type render.md.UserConfig
		ft = { 'markdown', 'quarto' },
	},
	{
		'rebelot/terminal.nvim',
		config = function()
			require("terminal").setup({ layout = { open_cmd = "botright new" }, })

			local term_map = require("terminal.mappings")
			vim.keymap.set("n", "<leader>to", term_map.toggle)
			vim.keymap.set('t', '<esc>', [[<C-\><C-n>]])
		end,
	},
	{
		"X3eRo0/dired.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
		config = function()
			require("dired").setup {
				path_separator = "/",
				show_banner = false,
				show_icons = true,
				show_hidden = true,
				show_dot_dirs = true,
				show_colors = true,

				colors = {
					DiredDimText = { link = {}, bg = "NONE", fg = "505050", gui = "NONE" },
					DiredDirectoryName = { link = {}, bg = "NONE", fg = "9370DB", gui = "NONE" },
					-- ... (define more colors as needed)
					DiredMoveFile = { link = {}, bg = "NONE", fg = "ff3399", gui = "bold" },
				},
			}
			vim.keymap.set("n", "<leader>pv", "<cmd>Dired<cr>")
		end
	}
}
