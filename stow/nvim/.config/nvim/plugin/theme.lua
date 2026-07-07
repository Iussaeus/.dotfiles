-- note: vscode colorscheme
-- vim.pack.add({ 'https://github.com/Mofiqul/vscode.nvim' })
-- local c = require 'vscode.colors'.get_colors()
-- require('vscode').setup({
--   transparent = true,
--   italic_comments = true,
--   underline_links = true,
--   disable_nvimtree_bg = true,
--   terminal_colors = true,
--   color_overrides = {
--     vscLineNumber = '#FFFFFF',
--   },
--   group_overrides = {
--     Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
--   }
-- })
-- vim.cmd.colorscheme 'vscode'

-- note: rose-pine colorscheme
vim.pack.add({ { src = "https://github.com/rose-pine/neovim", name = "rose-pine", } })
require("rose-pine").setup({
  variant = "moon",      -- auto, main, moon, or dawn
  dark_variant = "moon", -- main, moon, or dawn
  dim_inactive_windows = false,
  extend_background_behind_borders = true,

  enable = {
    terminal = true,
    legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
    migrations = true,        -- Handle deprecated options automatically
  },

  styles = {
    bold = true,
    italic = true,
    transparency = true,
  },
})
vim.cmd('colorscheme rose-pine-moon')

vim.opt.list = true
vim.opt.listchars = { tab = '▸ ', lead = '•', trail = '•', eol = '↵' }
vim.api.nvim_set_hl(0, 'whitespace', { ctermfg = 'darkgrey', fg = '#505050' })
vim.api.nvim_set_hl(0, 'NonText', { ctermfg = 'darkgrey', fg = '#707070' })
vim.api.nvim_set_hl(0, '@character.printf', { link = '@string.escape' })

vim.api.nvim_set_hl(0, 'Pmenu', {})

vim.api.nvim_set_hl(0, 'Cursor', { fg = '#505050', bg = '#FFCCCC' })

vim.api.nvim_set_hl(0, '@type.builtin', { link = 'Keyword' })
vim.api.nvim_set_hl(0, '@constant.builtin', { link = 'Keyword' })
vim.api.nvim_set_hl(0, '@boolean', { link = 'Keyword' })
vim.api.nvim_set_hl(0, '@type', { link = '@constant' })
vim.api.nvim_set_hl(0, '@module', { link = '@function' })
vim.api.nvim_set_hl(0, '@markup.heading', { link = '@function' })
vim.api.nvim_set_hl(0, 'Number', { link = '@field' })
