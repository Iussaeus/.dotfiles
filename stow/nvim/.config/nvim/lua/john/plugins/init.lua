return {
	'nvim-tree/nvim-web-devicons',
	{
		'windwp/nvim-autopairs',
		opts = {
			map_bs = false,
			map_c_h = false, -- map <C-h> key to delete a pair
			map_c_w = false, -- map <C-w> to delete a pair
		},
	},
	{
		'numToStr/Comment.nvim',
		config = function()
			require 'Comment'.setup()
				vim.keymap.del("n" ,"gbc")
		end
	},
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				keymaps = {
					normal = "s"
				}
			})
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
		'MeanderingProgrammer/render-markdown.nvim',
		dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
		opts = {},
		ft = { 'markdown', 'quarto' },
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "markdown",
				callback = function()
					vim.opt_local.formatoptions:append("r")
					vim.opt_local.comments = {
						"b:- [ ]",
						"b:-",
					}
				end,
			})
		end
	},
	{
		'rebelot/terminal.nvim',
		config = function()
			require("terminal").setup({ layout = { open_cmd = "botright new" }, })

			local term_map = require("terminal.mappings")
			vim.keymap.set("n", "<leader>to", term_map.toggle)
			vim.keymap.set('t', '<esc><esc>', [[<C-\><C-n>]])
		end,
	},
	{
		"folke/snacks.nvim",
		keys = {
			{ "<leader>ss", function() require 'snacks'.scratch.open({ name = "scratch", icon = "*", ft = "markdown" }) end },
			{ "<leader>sb", function()
				require 'snacks'.scratch.select()
			end },
		},
		opts = {
			{
				bigfile = { enabled = false },
				dashboard = { enabled = false },
				explorer = { enabled = false },
				indent = { enabled = false },
				input = { enabled = false },
				picker = { enabled = false },
				notifier = { enabled = false },
				quickfile = { enabled = false },
				scope = { enabled = false },
				scroll = { enabled = false },
				statuscolumn = { enabled = false },
				words = { enabled = false },
				scratch = { enabled = true },
			},
			styles = {
				scratch = {
					width = 0.9,
					height = 0.9,
					bo = { buftype = "", buflisted = false, bufhidden = "hide", swapfile = false, filetype = "markdown" },
					noautocmd = false,
				},
			},
		},
	},
	{
		"chentoast/marks.nvim",
		event = "VeryLazy",
		opts = {
			default_mappings = false,
		},
		init = function()
			vim.keymap.set("n", "<leader>mm", "<cmd>MarksQFListAll<cr>")
		end
	},
	{
		"mbbill/undotree",
		init = function()
			vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
		end
	},
	{
		"chrisgrieser/nvim-spider",
		opts = {
			skipInsignificantPunctuation = false,
		},
		keys = {
			{ "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" } },
			{ "e", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" } },
			{ "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" } },
		},
	},
	{
		'linux-cultist/venv-selector.nvim',
		dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap-python' },
		branch = "regexp",
		keys = {
			{ '<leader>vs', '<cmd>VenvSelect<cr>' },
			{ '<leader>vc', '<cmd>VenvSelectCached<cr>' },
		},
		config = function()
			require'venv-selector'.setup()
		end
	},
}
