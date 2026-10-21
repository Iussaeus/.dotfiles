-- Move code in visual mode
vim.keymap.set('v', 'J', [[:m '>+1<CR>gv=gv]])
vim.keymap.set('v', 'K', [[:m '<-2<CR>gv=gv]])

-- Paste stuff and not add anything to " register
vim.keymap.set({ 'n', 'v' }, '<leader>p', [["_dP]])

-- Copy stuff to + register(clipboard)
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])

-- Pane navigation and resizing
vim.keymap.set('n', '<a-n>', function() return ('<C-W>%d<'):format(vim.v.count1 == 1 and 3 or vim.v.count1) end, {expr = true})
vim.keymap.set('n', '<a-.>', function() return ('<C-W>%d>'):format(vim.v.count1 == 1 and 3 or vim.v.count1) end, {expr = true})
vim.keymap.set('n', '<a-,>', function() return ('<C-W>%d+'):format(vim.v.count1 == 1 and 3 or vim.v.count1) end, {expr = true})
vim.keymap.set('n', '<a-m>', function() return ('<C-W>%d-'):format(vim.v.count1 == 1 and 3 or vim.v.count1) end, {expr = true})

-- Terminal only mappings
vim.keymap.set('t', '<esc>', '<C-\\><C-n>')

vim.keymap.set('n', '<up>', '<cmd>cnext<cr>')
vim.keymap.set('n', '<down>', '<cmd>cprevious<cr>')
vim.keymap.set('n', '<leader>qfo', '<cmd>:copen<cr>')

vim.keymap.set('n', '<m-up>', '<cmd>:lnext<cr>')
vim.keymap.set('n', '<m-down>', '<cmd>:lprevious<cr>')
vim.keymap.set('n', '<leader>lco', '<cmd>:lopen<cr>')
