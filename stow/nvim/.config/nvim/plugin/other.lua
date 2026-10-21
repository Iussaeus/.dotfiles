-- random dependencies
vim.pack.add { 'https://github.com/nvim-treesitter/nvim-treesitter' }
vim.pack.add { 'https://github.com/kylechui/nvim-surround' }
vim.pack.add { 'https://github.com/nvim-treesitter/nvim-treesitter-context' }
vim.pack.add { 'https://github.com/MunifTanjim/nui.nvim' }
vim.pack.add({ "https://github.com/tpope/vim-fugitive" })

-- undo
vim.cmd.packadd 'nvim.undotree'
vim.keymap.set({ 'n', 'x' }, '<m-u>', vim.cmd.Undotree)

-- align
vim.pack.add({ 'https://github.com/nvim-mini/mini.align' })
require 'mini.align'.setup { mappings = { start = nil, start_with_preview = 'ga', }, }

-- git-signs
vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })
require "gitsigns".setup()
vim.keymap.set("n", "<leader>hr", "<cmd>Gitsigns reset_hunk<cr>")
vim.keymap.set("v", "<leader>hr", ":'<,'>Gitsigns reset_hunk<cr>")
