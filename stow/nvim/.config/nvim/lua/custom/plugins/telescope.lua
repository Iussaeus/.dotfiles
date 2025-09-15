return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.6',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    { '<leader>pf', '<cmd>Telescope find_files<cr>' },
    { '<leader>pg', '<cmd>Telescope live_grep<cr>' },
    { '<leader>pd', '<cmd>Telescope diagnostics<cr>' },
    { '<leader>th', '<cmd>Telescope help_tags<cr>' },
    { '<leader>tc', '<cmd>Telescope commands<cr>' },
    { '<leader>tt', '<cmd>Telescope current_buffer_tags<cr>' },
    { '<leader>tb', '<cmd>Telescope builtin<cr>' },
  },

  config = function()
    require 'telescope'.setup {
      defaults = {
        file_ignore_patterns = {
          '%.log$',
          '%.tmp$',
          '%.bak$',
          '%.tscn$',
          '%.tres$',
          '%.import$',
          '%.png$',
          '%.svg$',
          '%.glb$',
          '.git/',
        },
      },
      pickers = {
        find_files = {
          find_command = {
            'rg',
            '--files',
            '--color',
            'never',
            '--hidden',
            '--no-ignore-vcs',
          },
        },
        live_grep = {
          vimgrep_arguments = {
            'rg',
            '--no-ignore',
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
  end
}
