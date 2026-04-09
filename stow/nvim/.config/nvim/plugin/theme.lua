vim.pack.add({ 'https://github.com/Mofiqul/vscode.nvim' })
local c = require 'vscode.colors'.get_colors()
require('vscode').setup({
  transparent = true,
  italic_comments = true,
  underline_links = true,
  disable_nvimtree_bg = true,
  terminal_colors = true,
  color_overrides = {
    vscLineNumber = '#FFFFFF',
  },
  group_overrides = {
    Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
  }
})
vim.opt.list = true
vim.opt.listchars = { tab = '▸ ', lead = '•', trail = '•', eol = '↵' }
vim.cmd.colorscheme 'vscode'
vim.cmd('highlight whitespace ctermfg=darkgrey guifg=#303030')
vim.cmd('highlight NonText ctermfg=darkgrey guifg=#505050')
