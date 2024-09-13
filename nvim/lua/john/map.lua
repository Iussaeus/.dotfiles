-- Leader key
vim.g.mapleader = " "

-- Go to Explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Get the hell out
vim.keymap.set("n", "q:", "<NOP>")

-- Move code in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Move code in visual mode
vim.keymap.set("n", "j", "jzz")
vim.keymap.set("n", "k", "kzz")

-- Yank stuff in void register
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Append the tex below the cursor to the current line
vim.keymap.set("n", "J", "mzJ`z")

-- Center the cursor when navigating the code
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Copy stuff to + register(clipboard)
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Change all ocurences of the current word at the cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- go special
vim.keymap.set("n", "<leader>en", "iif err != nil {<CR>return err<CR>}<ESC>k_v$h")
