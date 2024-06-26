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
					disable = {"ocaml"},
				},
				ensure_installed = {
					"ocaml",
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
