-- Tab navigation, not that I need it
vim.keymap.set('n', '<left>', 'gT')
vim.keymap.set('n', '<right>', 'gt')

-- Get the hell out
vim.keymap.set('n', 'q:', '<nop>')

-- Move code in visual mode
vim.keymap.set('v', 'J', [[:m '>+1<CR>gv=gv]])
vim.keymap.set('v', 'K', [[:m '<-2<CR>gv=gv]])

-- Yank stuff in void register
vim.keymap.set('x', '<leader>p', [['_dP]])

-- Append the text below the cursor to the current line
vim.keymap.set('n', 'J', 'mzJ`z')

-- Center the cursor when navigating the code
local centered_keymaps = { '<C-d>', '<C-u>', 'u', '<C-r>', 'n', 'N', 'gg', 'G', '*', '#', 'j', 'k' }
for _, keymap in ipairs(centered_keymaps) do
  vim.keymap.set('n', keymap, keymap .. 'zzzv')
  vim.keymap.set('n', keymap, keymap .. 'zzzv')
end

-- Copy stuff to + register(clipboard)
vim.keymap.set({ 'n', 'v' }, '<leader>y', [['+y]])

-- Pane navigation
local close_not_focused_wins = function()
  vim.iter(vim.api.nvim_tabpage_list_wins(0))
      :filter(function(w)
        return w ~= vim.api.nvim_get_current_win()
      end)
      :each(function(w)
        vim.api.nvim_win_close(w, true)
      end)
end

vim.keymap.set('n', 'gd', '<c-]>')

vim.keymap.set('n', '<leader>ff', close_not_focused_wins)
vim.keymap.set('n', '<leader>h', '<C-W>h_')
vim.keymap.set('n', '<leader>j', '<C-W>j_')
vim.keymap.set('n', '<leader>k', '<C-W>k_')
vim.keymap.set('n', '<leader>l', '<C-W>l_')
vim.keymap.set('n', '<a-n>', '<C-W><')
vim.keymap.set('n', '<a-.>', '<C-W>>')
vim.keymap.set('n', '<a-,>', '<C-W>+')
vim.keymap.set('n', '<a-m>', '<C-W>-')

-- Terminal only mappings
vim.keymap.set('t', '<esc>', '<C-\\><C-n>')

vim.keymap.set('n', '<up>', '<cmd>cnext<cr>')
vim.keymap.set('n', '<down>', '<cmd>cprevious<cr>')
vim.keymap.set('n', '<leader>qfo', '<cmd>:copen<cr>')

vim.keymap.set('n', '<m-up>', '<cmd>:lnext<cr>')
vim.keymap.set('n', '<m-down>', '<cmd>:lprevious<cr>')
vim.keymap.set('n', '<leader>lco', '<cmd>:lopen<cr>')
