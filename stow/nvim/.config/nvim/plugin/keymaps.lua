vim.api.nvim_create_user_command("W", "w", { desc = "write" })
vim.api.nvim_create_user_command("Wq", "wq", { desc = "write'n'quit" })
vim.api.nvim_create_user_command("WQ", "wq", { desc = "write'n'quit" })
vim.api.nvim_create_user_command("Q", "q", { desc = "quit" })

-- Tab navigation, not that I need it
vim.keymap.set("n", "<left>", "gT")
vim.keymap.set("n", "<right>", "gt")

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
local center_keymaps = { "<C-d>", "<C-u>", "u", "<C-r>", "n", "N", "gg", "G" }
for _, keymap in ipairs(center_keymaps) do
  vim.keymap.set("n", keymap, keymap .. "zz")
end

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
vim.keymap.set("n", "<M-n>", "<C-W>5<")
vim.keymap.set("n", "<M-.>", "<C-W>5>")
vim.keymap.set("n", "<M-,>", "<C-W>5+")
vim.keymap.set("n", "<M-m>", "<C-W>5-")

-- Terminal only mappings
vim.api.nvim_set_keymap('t', '<esc><esc>', '<C-\\><C-n>', { noremap = true, silent = true })


vim.keymap.set('n', '<up>', ':cnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<down>', ':cprevious<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>qfo', ':copen<CR>', { noremap = true, silent = true })
