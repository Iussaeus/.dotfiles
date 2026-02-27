return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.6',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    { '<leader>tf', '<cmd>Telescope find_files<cr>' },
    { '<leader>tg', '<cmd>Telescope live_grep<cr>' },
    { '<leader>th', '<cmd>Telescope help_tags<cr>' },
    { '<leader>tc', '<cmd>Telescope commands<cr>' },
    { '<leader>tb', '<cmd>Telescope builtin<cr>' },
  },

  config = function()
    require 'telescope'.setup {
      defaults = {
        file_ignore_patterns = {
          -- '%.log$',
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
            -- 'rg',
            -- '--files',
            -- -- '-l',
            -- -- '.*',
            -- '-uu',
            -- '--color=never',
            -- '--smart-case',
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
  end
}
