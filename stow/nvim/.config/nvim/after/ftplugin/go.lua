vim.opt_local.expandtab = false
vim.opt_local.softtabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4

vim.keymap.set("n", "<leader>en", "oif err != nil {<CR>return err<CR>}<ESC>k_v$h")
