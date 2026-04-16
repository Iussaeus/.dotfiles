vim.pack.add({'https://github.com/nvim-treesitter/nvim-treesitter'})
vim.pack.add({'https://github.com/kylechui/nvim-surround'})
vim.pack.add({'https://github.com/chrisgrieser/nvim-spider'})
vim.pack.add({'https://github.com/chrisgrieser/nvim-spider'})

vim.pack.add({'https://github.com/ray-x/lsp_signature.nvim'})
require'lsp_signature'.setup({hint_enable = 'false', floating_window = false})

vim.keymap.set({ 'n', 'o', 'x' }, 'w', "<cmd>lua require('spider').motion('w')<CR>")
vim.keymap.set({ 'n', 'o', 'x' }, 'e', "<cmd>lua require('spider').motion('e')<CR>")
vim.keymap.set({ 'n', 'o', 'x' }, 'b', "<cmd>lua require('spider').motion('b')<CR>")
