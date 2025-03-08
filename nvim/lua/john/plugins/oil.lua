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
			show_hidden = true,
			natural_order = "fast",
		},
		lsp_file_methods = {
			enabled = true,
			timeout_ms = 1000,
			autosave_changes = false,
		},
	},
	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
	lazy = false,
	init = function()
		vim.keymap.set("n", "<leader>pv", "<cmd>Oil<cr>")
	end
}
