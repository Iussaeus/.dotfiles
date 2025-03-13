return {
	"ej-shafran/compile-mode.nvim",
	vesion = "5.*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "m00qek/baleia.nvim", tag = "v1.3.0" },
	},
	config = function()
		vim.g.compile_mode = {
			baleia_setup = true,
			default_command = "",
			use_diagnostics = true,
		}

		vim.keymap.set("n", "<leader>cm", "<cmd>:botright 15 :Compile<cr>")
		vim.keymap.set("n", "<leader>cr", "<cmd>:botright 15 :Recompile<cr>")
		vim.keymap.set("n", "<leader>cn", require 'compile-mode'.next_error)
		vim.keymap.set("n", "<leader>cp", require 'compile-mode'.prev_error)
	end
}
