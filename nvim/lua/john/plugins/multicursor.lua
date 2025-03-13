return {
	{
		'mg979/vim-visual-multi',
		branch = 'master',
		lazy = false,
		init = function()
			vim.g.VM_set_statusline = 0
			vim.g.VM_skip_empty_lines = 1
			vim.g.VM_silent_exit = 1
			vim.g.VM_default_mappings = 0

			vim.g.VM_maps = {
				["Visual Cursors"]  = "<C-n>",
				["Run Normal"]      = "<leader>nn",
				["Run Visual"]      = "<leader>vv",
				["Find Next"]       = "<C-n>",
				["Find Prev"]       = "<C-p>",
				["Add Cursor Down"] = "<C-Down>",
				["Add Cursor Up"]   = "<C-Up>",
				["Align"]           = "<leader>a",
				["Align Char"]      = "<leader>ac",
			}
		end,

		config = function()
			vim.api.nvim_set_hl(0, "VM_Mono", { link = "Cursor" })
			vim.api.nvim_set_hl(0, "VM_Extend", { link = "Visual" })
			vim.api.nvim_set_hl(0, "VM_Cursor", { link = "Cursor" })
			vim.api.nvim_set_hl(0, "VM_Insert", { link = "CursorLine" })
		end,
	},
}
