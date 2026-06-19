vim.pack.add({ 'https://github.com/folke/todo-comments.nvim' })

require 'todo-comments'.setup({
  highlight = {
    multiline = true,                 -- enable multine todo comments
    multiline_pattern = "^.",         -- lua pattern to match the next multiline from the start of the matched keyword
    multiline_context = 10,           -- extra lines that will be re-evaluated when changing a line
    before = "",                      -- "fg" or "bg" or empty
    keyword = "wide",                 -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
    after = "fg",                     -- "fg" or "bg" or empty
    pattern = [[.*((KEYWORDS).*): ]], -- pattern or table of patterns, used for highlighting (vim regex)
    comments_only = true,             -- uses treesitter to match keywords in comments only
    max_line_len = 400,               -- ignore lines longer than this
    exclude = {},                     -- list of file types to exclude highlighting
  },
  keywords = {
    TODO = { icon = ' ', color = 'info', alt = { 'todo', 'Todo' } },
    WARN = { icon = ' ', color = 'warning', alt = { 'WARNING', 'XXX', 'warn', 'warning', 'xxx', 'Warn', 'Warning', 'HACK', 'Hack', 'hack' } },
    NOTE = { icon = ' ', color = 'hint', alt = { 'NOTE', 'INFO', 'Note', 'Info', 'info', 'note' } },
    TEST = { icon = '⏲ ', color = 'test', alt = { 'TESTING', 'PASSED', 'FAILED', 'testing', 'passed', 'failed', 'Testing', 'Passed', 'Failed' } },
    FIX = { icon = ' ', color = 'error', alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE', 'fix', 'fixme', 'bug', 'fixit', 'Fix', 'Issue', 'Fixme', 'Bug', 'Fixit', 'Issue' } },
  }
})

vim.keymap.set('n', '<leader>tdf', '<cmd>TodoTelescope<cr>')
vim.keymap.set('n', '<leader>tdl', '<cmd>TodoLocList<cr>')
