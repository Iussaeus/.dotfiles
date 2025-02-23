return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.6',
	dependencies = { 'nvim-lua/plenary.nvim' },
	keys = {
		{ "<leader>pf", "<cmd>Telescope find_files<cr>",  desc = "find file" },
		{ "<leader>ps", "<cmd>Telescope grep_string<cr>", desc = "grep search" },
		{ "<leader>pd", "<cmd>Telescope diagnostics<cr>" },
		{ "<leader>vh", "<cmd>Telescope help_tags<cr>",   desc = "help tags" },
	},
	config = function()
		require 'telescope'.setup {
			defaults = {
				file_ignore_patterns = { "%.log$", "%.tmp$", "%.bak$", "%.tscn$", "%.tres$", "%.import$", "%.png$", "%.svg$", "%.glb$" }
			},
		}
	end
}
