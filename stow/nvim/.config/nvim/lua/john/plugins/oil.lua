return {
	'stevearc/oil.nvim',
		---@module 'oil'
			---@type oil.SetupOpts
			opts = {
				keymaps = {
					["<C-h>"] = false,
					["<C-l>"] = false,
					["<leader>p"] = false,
					["<c-p"] = false,
				},
				columns = {
					"icon",
					"permissions",
					"size",
					"mtime",
				},
				constrain_cursor = "name",
				delete_to_trash = true,
				view_options = {
					show_hidden = true,
					natural_order = "fast",
				},
				watch_for_changes = true,
				'stevearc/oil.nvim',
				---@module 'oil'
					---@type oil.SetupOpts
					opts = {
						keymaps = {
							["<C-h>"] = false,
							["<C-l>"] = false,
							["<leader>p"] = false,
							["<c-p"] = false,
						},
						columns = {
							"icon",
							"permissions",
							"size",
						},
						constrain_cursor = "name",
						delete_to_trash = true,
						view_options = {
							show_hidden = true,
							natural_order = "fast",
						},

					},
				dependencies = { "nvim-tree/nvim-web-devicons" },
			}
}
