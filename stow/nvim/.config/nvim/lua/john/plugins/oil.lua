return {
<<<<<<< HEAD
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
=======
>>>>>>> 3b1aecf (work configs)
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
<<<<<<< HEAD
>>>>>>> 3c7a26e (changed the nvim config)
=======
=======
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
>>>>>>> 66529a3 (work configs)
>>>>>>> 3b1aecf (work configs)

    },
    dependencies = { "nvim-tree/nvim-web-devicons" },

<<<<<<< HEAD
<<<<<<< HEAD
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
    init = function()
        vim.keymap.set("n", "<leader>pv", "<cmd>Oil<cr>")
    end
=======
=======
>>>>>>> 3b1aecf (work configs)
	lazy = false,
	init = function()
		vim.keymap.set("n", "<leader>pv", "<cmd>Oil<cr>")
	end
<<<<<<< HEAD
>>>>>>> 3c7a26e (changed the nvim config)
=======
=======
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
    init = function()
        vim.keymap.set("n", "<leader>pv", "<cmd>Oil<cr>")
    end
>>>>>>> 66529a3 (work configs)
>>>>>>> 3b1aecf (work configs)
}
