return {
	"ej-shafran/compile-mode.nvim",
	vesion = "5.*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "m00qek/baleia.nvim", tag = "v1.3.0" },
	},
	config = function()
		---@type CompileModeOpts
		vim.g.compile_mode = {
			baleia_setup = true,
			default_command = "",
		}
		vim.keymap.set("n", "<space>cm", ":botright :Compile");
	end
}
