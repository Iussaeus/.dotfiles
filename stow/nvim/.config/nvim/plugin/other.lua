vim.pack.add { 'https://github.com/nvim-treesitter/nvim-treesitter' }
vim.pack.add { 'https://github.com/kylechui/nvim-surround' }
vim.pack.add { 'https://github.com/nvim-treesitter/nvim-treesitter-context' }
vim.pack.add { 'https://github.com/MunifTanjim/nui.nvim' }

vim.pack.add { 'https://github.com/glacambre/firenvim' }
vim.cmd [[ :call firenvim#install(0) ]]
if vim.g.started_by_firenvim then
  vim.o.guifont = 'CaskaydiaCove Nerd Font Mono:h9'
  vim.o.sidescrolloff = 0
  vim.o.scrolloff = 0
  vim.opt.signcolumn = "no"
end

vim.cmd.packadd 'nvim.undotree'
vim.keymap.set({ 'n', 'x' }, '<m-u>', vim.cmd.Undotree)
