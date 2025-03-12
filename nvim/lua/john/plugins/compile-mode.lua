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

		vim.keymap.set("n", "<space>cm", "<cmd>:botright 10 :Compile<cr>")
		vim.keymap.set("n", "<space>cr", "<cmd>:botright 10 :Recompile<cr>")
		vim.keymap.set("n", "<space>cn", function() cm.next_error() end)
		vim.keymap.set("n", "<space>cp", function() cm.prev_error() end)
	end
}
