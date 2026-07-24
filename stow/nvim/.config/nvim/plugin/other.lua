vim.pack.add { 'https://github.com/nvim-treesitter/nvim-treesitter' }
vim.pack.add { 'https://github.com/kylechui/nvim-surround' }
vim.pack.add { 'https://github.com/nvim-treesitter/nvim-treesitter-context' }

vim.cmd.packadd 'nvim.undotree'
vim.keymap.set({ 'n', 'x' }, '<m-u>', vim.cmd.Undotree)
