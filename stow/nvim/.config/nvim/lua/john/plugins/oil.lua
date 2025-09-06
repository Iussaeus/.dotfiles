return {
<<<<<<< HEAD
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
        keymaps = {
            ["<C-h>"] = false,
            ["<C-l>"] = false,
            ["<leader>p"] = "actions.preview",
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
=======
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
>>>>>>> 3c7a26e (changed the nvim config)

    },
    dependencies = { "nvim-tree/nvim-web-devicons" },

<<<<<<< HEAD
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
    init = function()
        vim.keymap.set("n", "<leader>pv", "<cmd>Oil<cr>")
    end
=======
	lazy = false,
	init = function()
		vim.keymap.set("n", "<leader>pv", "<cmd>Oil<cr>")
	end
>>>>>>> 3c7a26e (changed the nvim config)
}
