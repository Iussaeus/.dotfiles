return {
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>gd", "<cmd>Gvdiffsplit<CR>")
			vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
		end
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require "gitsigns".setup()

			vim.keymap.set("n", "<leader>gh", "<cmd>Gitsigns preview_hunk_inline<cr>")
			vim.keymap.set("n", "<leader>rh", "<cmd>Gitsigns reset_hunk<cr>")
			vim.keymap.set("n", "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>")
			vim.keymap.set("n", "<leader>gd", "<cmd>Gitsigns toggle_deleted<cr>")
		end,
	}
}
