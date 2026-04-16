vim.g.mapleader = ' '

vim.loader.enable()
vim.cmd.packadd 'nvim.undotree'
vim.keymap.set({ 'n', 'x' }, '<leader>u', vim.cmd.Undotree)

vim.pack.add({ 'https://github.com/nvim-lua/plenary.nvim' })
vim.pack.add({ 'https://github.com/nvim-tree/nvim-web-devicons' })
