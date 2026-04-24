vim.pack.add({ {
  src = 'https://github.com/nvim-telescope/telescope.nvim',
  version = vim.version.range '0.2.x',
} })

require 'telescope'.setup {
  defaults = {
    file_ignore_patterns = {
      '%.zip$',
      '%.7z$',
      '%.tmp$',
      '%.bak$',
      '%.tscn$',
      '%.tres$',
      '%.import$',
      '%.png$',
      '%.svg$',
      '%.glb$',
      '%.uid$',
      '%.x86_64$',
      'vendor/',
      '.git/',
      '.godot/',
    },
  },
  pickers = {
    find_files = {
      find_command = {
        'find',
        '.',
        '-type',
        'f',
        '-not',
        '-executable',
      },
    },
    live_grep = {
      vimgrep_arguments = {
        'rg',
        '-uu',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
        '--trim',
      },
    }
  },
}

vim.keymap.set({ 'n', 'v' }, '<leader>ff', '<cmd>Telescope find_files<cr>')
vim.keymap.set({ 'n', 'v' }, '<leader>gr', '<cmd>Telescope live_grep<cr>')
vim.keymap.set({ 'n', 'v' }, '<leader>gf', '<cmd>Telescope git_files<cr>')
vim.keymap.set({ 'n', 'v' }, '<leader>th', '<cmd>Telescope help_tags<cr>')
vim.keymap.set({ 'n', 'v' }, '<leader>tc', '<cmd>Telescope commands<cr>')
vim.keymap.set({ 'n', 'v' }, '<leader>tb', '<cmd>Telescope builtin<cr>')
