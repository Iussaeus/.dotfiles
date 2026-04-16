vim.pack.add({ 'https://github.com/nvim-lualine/lualine.nvim' })

local function highlight_range_in_string(s, start, finish)
  if type(s) ~= "string" then return "" end
  start = math.max(1, math.floor(start or 1))
  finish = math.max(start, math.floor(finish or start))

  local pre   = vim.fn.strcharpart(s, 0, start - 1)
  local mid   = vim.fn.strcharpart(s, start - 1, finish - start + 1)
  local post  = vim.fn.strcharpart(s, finish, 1e6)

  return pre .. "%#LspSignatureActiveParameter#" .. mid .. "%#LualineNormal#" .. post
end

require 'lualine'.setup {
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
          if vim.g.Vm.extend_mode == 0 then
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
    lualine_b = { 'branch', 'diff' },
    lualine_c = {
      'filename',
      {
        'diagnostics',
        fmt = function()
          if not pcall(require, 'lsp_signature') then return end
          local sig = require("lsp_signature").status_line()
          if sig.label == '' then
            return
          end

          if sig.hint ~= '' then
            return highlight_range_in_string(sig.label, sig.range.start, sig.range['end'])
          end

          return sig.label
        end
      },
    },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_z = { { 'location', separator = { left = '' } } }
  },
}
