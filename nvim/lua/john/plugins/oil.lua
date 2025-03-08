return {
	'stevearc/oil.nvim',
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {
		columns = {
			"icon",
			"permissions",
			"size",
		},
		delete_to_trash = true,
		view_options = {
			-- Show files and directories that start with "."
			show_hidden = true,
			natural_order = "fast",
			-- Sort file and directory names case insensitive
			case_insensitive = false,
			-- Customize the highlight group for the file name
			highlight_filename = function(entry, is_hidden, is_link_target, is_link_orphan)
				return nil
			end,
		},
	},
	-- Optional dependencies
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
	-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
	lazy = false,
	init = function(opts)
		vim.keymap.set("n", "<leader>pv", "<cmd>Oil<cr>")
	end
}
