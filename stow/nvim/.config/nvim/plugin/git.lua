vim.pack.add({ "https://github.com/tpope/vim-fugitive" })
vim.keymap.set("n", "<leader>gd", vim.cmd.Gvdiffsplit)
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })
require "gitsigns".setup()
vim.keymap.set("n", "<leader>hv", "<cmd>Gitsigns preview_hunk<cr>")
vim.keymap.set("n", "<leader>hr", "<cmd>Gitsigns reset_hunk<cr>")

vim.keymap.set("v", "<leader>hr", ":'<,'>Gitsigns reset_hunk<cr>")
vim.keymap.set("v", "<leader>hv", ":'<,'>Gitsigns preview_hunk<cr>")

vim.keymap.set("n", "<leader>lb", "<cmd>Gitsigns toggle_current_line_blame<cr>")
vim.keymap.set("n", "<leader>gd", "<cmd>Gitsigns toggle_deleted<cr>")
