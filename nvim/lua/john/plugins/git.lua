return {
	{
		"tpope/vim-fugitive",
		config =function ()
			vim.keymap.set("n", "<leader>gd", ":Gvdiffsplit<CR>")
			vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
		end
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require "gitsigns".setup()

			vim.keymap.set("n", "<leader>gh", ":Gitsigns preview_hunk<CR>")
		end,
	}
}
