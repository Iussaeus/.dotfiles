-- Leader key
vim.g.mapleader = " "

vim.keymap.set("i", "<c-h>", "<esc>vbda")

vim.api.nvim_create_user_command("W", "w", { desc = "write" })
vim.api.nvim_create_user_command("Wq", "wq", { desc = "write'n'quit" })
vim.api.nvim_create_user_command("WQ", "wq", { desc = "write'n'quit" })
vim.api.nvim_create_user_command("Q", "q", { desc = "quit" })

-- Go to Explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Get the hell out
vim.keymap.set("n", "q:", "<NOP>")

-- Move code in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Yank stuff in void register
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Append the tex below the cursor to the current line
vim.keymap.set("n", "J", "mzJ`z")

-- Center the cursor when navigating the code
vim.keymap.set("n", "k", "kzz")
vim.keymap.set("n", "j", "jzz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "gg", "ggzz")
vim.keymap.set("n", "G", "Gzz")

-- Copy stuff to + register(clipboard)
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Change all ocurences of the current word at the cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Pane navigation
-- TODO: keymap for deleting every pane but the focused one
vim.keymap.set("n", "<leader>ff", "<C-W>500+<C-W>500>_")
vim.keymap.set("n", "<leader>vs", "<cmd>vs<cr>")
vim.keymap.set("n", "<leader>h", "<C-W>h_")
vim.keymap.set("n", "<leader>j", "<C-W>j_")
vim.keymap.set("n", "<leader>k", "<C-W>k_")
vim.keymap.set("n", "<leader>l", "<C-W>l_")
vim.keymap.set("n", "<leader>H", "<C-W>10<")
vim.keymap.set("n", "<leader>J", "<C-W>10+")
vim.keymap.set("n", "<leader>K", "<C-W>10-")
vim.keymap.set("n", "<leader>L", "<C-W>10>")
