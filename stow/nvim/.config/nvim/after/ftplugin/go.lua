<<<<<<< HEAD
vim.opt_local.expandtab = false
vim.opt_local.softtabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4

vim.keymap.set("n", "<leader>en", "oif err != nil {<CR>return err<CR>}<ESC>k_v$h")
=======
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = false

vim.keymap.set("n", "<leader>en", "oif err != nil {<CR>return err<CR>}<ESC>k_v$h")
vim.keymap.set("n", "<leader>enp", "oif err != nil {<CR>return fmt.Printf(\"Err: %s\", err)<CR>}<ESC>")
>>>>>>> 3c7a26e (changed the nvim config)
