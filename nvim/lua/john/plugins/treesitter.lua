return{
	{
		'nvim-treesitter/nvim-treesitter',
		config = function ()
			local status, ts = pcall(require, "nvim-treesitter.configs")
			if (not status) then return end

			ts.setup {
				highlight = {
					enable = true,
					disable = {},
				},
				indent = {
					enable = true,
				},
				ensure_installed = {
					"ocaml", "gdscript", "c_sharp", "vimdoc",
				},
				sync_install = true,
				autotag = {
					enable = true,
				},
				rainbow = {
					enable = true,
					extended_mode = true,
					max_file_lines = nil,
				},
				autopairs = {
					enable = true,
				}
			}
		end,
	}
}
