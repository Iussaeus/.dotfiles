vim.pack.add({ 'https://github.com/folke/todo-comments.nvim' })

require 'todo-comments'.setup({
  highlight = {
    multiline = true,                       -- enable multine todo comments
    multiline_pattern = "^.",               -- lua pattern to match the next multiline from the start of the matched keyword
    multiline_context = 10,                 -- extra lines that will be re-evaluated when changing a line
    after = "fg",                             -- "fg" or "bg" or empty
    pattern = [[\s((KEYWORDS)(\(.+\))?):]], -- pattern or table of patterns, used for highlighting (vim regex)
    comments_only = true,                   -- uses treesitter to match keywords in comments only
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
