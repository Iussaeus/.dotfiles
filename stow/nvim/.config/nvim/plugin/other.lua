vim.pack.add { 'https://github.com/nvim-treesitter/nvim-treesitter' }
vim.pack.add { 'https://github.com/kylechui/nvim-surround' }
vim.pack.add { 'https://github.com/nvim-treesitter/nvim-treesitter-context' }
vim.pack.add { 'https://github.com/MunifTanjim/nui.nvim' }

vim.pack.add { 'https://github.com/glacambre/firenvim' }
vim.cmd [[ :call firenvim#install(0) ]]
if vim.g.started_by_firenvim then
  vim.api.nvim_create_user_command('W', function()
    vim.cmd([[silent! write]])
    vim.cmd([[echo ""]]) -- Instantly clears any leftover flash
  end, {})

  vim.cmd([[cnoreabbrev w W]])
  vim.cmd([[cnoreabbrev write W ]])

  vim.keymap.set('n', 'u', ':silent undo<CR>', { silent = true, noremap = true })
  vim.keymap.set('n', '<C-r>', ':silent redo<CR>', { silent = true, noremap = true })

  vim.defer_fn(function()
    vim.opt.laststatus = 0
    vim.opt.shortmess = "aAsStToOFc"
    vim.opt.showmode = false
    vim.opt.cmdheight = 0
    vim.opt.showcmd = false
    vim.o.sidescrolloff = 0
    vim.o.scrolloff = 0
    vim.opt.signcolumn = "no"
  end, 10)

  vim.defer_fn(function()
    if vim.o.lines < 5 then
      vim.o.lines = 2
    end
  end, 70)

  vim.keymap.set({ 'n', 'i' }, '<c-e>', '<cmd>:wq<cr>')
  vim.o.guifont = 'CaskaydiaCove Nerd Font Mono:h9'
end

vim.cmd.packadd 'nvim.undotree'
vim.keymap.set({ 'n', 'x' }, '<m-u>', vim.cmd.Undotree)
