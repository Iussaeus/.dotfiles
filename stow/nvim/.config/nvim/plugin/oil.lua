vim.pack.add({ 'https://github.com/nvim-tree/nvim-web-devicons' })
vim.pack.add({'https://github.com/stevearc/oil.nvim'})
require'oil'.setup {
  keymaps = {
    ['<C-h>'] = false,
    ['<C-l>'] = false,
    ['<leader>p'] = false,
    ['<c-p'] = false,
  },
  columns = {
    'icon',
    'permissions',
    'size',
    'mtime',
  },
  win_options = {
    winbar = "%{v:lua.require('oil').get_current_dir()}",
  },
  constrain_cursor = 'name',
  delete_to_trash = true,
  view_options = {
    show_hidden = true,
    natural_order = 'fast',
  },
  watch_for_changes = true,
  dependencies = {  },
}

vim.keymap.set('n', '<leader>pd', vim.cmd.Oil)
