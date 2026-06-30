vim.pack.add({ 'https://github.com/nvim-treesitter/nvim-treesitter' })
vim.pack.add({ 'https://github.com/kylechui/nvim-surround' })

vim.pack.add({ 'https://github.com/chrisgrieser/nvim-spider' })
vim.keymap.set({ 'n', 'o', 'x' }, 'w', function() require('spider').motion('w') end)
vim.keymap.set({ 'n', 'o', 'x' }, 'e', function() require('spider').motion('e') end)
vim.keymap.set({ 'n', 'o', 'x' }, 'b', function() require('spider').motion('b') end)

vim.cmd.packadd 'nvim.undotree'
vim.keymap.set({ 'n', 'x' }, '<m-u>', vim.cmd.Undotree)
