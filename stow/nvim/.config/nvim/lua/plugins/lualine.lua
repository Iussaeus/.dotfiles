return {
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        globalstatus = true,
        icons_enabled = true,
        section_separators = { left = '|', right = '|' },
        component_separators = { left = '|', right = '|' },
        refresh = { statusline = 100, tabline = 100, winbar = 100, }
      },
      sections = {
        lualine_a = { {
          'mode',
          fmt = function(str)
            if vim.b.visual_multi then
              if vim.g.Vm.extend_mode == 0  then
                return 'VM-CURSOR'
              else
                return 'VM-EXTEND'
              end
            end
            return str
          end,
          color = function()
            if vim.b.visual_multi then
              return { bg = '#FF0100', fg = '#FFFFFF' }
            end
          end,
          separator = { right = '' },
        } },
        lualine_b = { 'branch', 'diff'},
        lualine_c = { 'diagnostics', 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_z = { { 'location', separator = { left = '' } } }
      },
    }
  }
}
