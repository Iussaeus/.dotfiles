vim.pack.add({ 'https://github.com/folke/todo-comments.nvim' })

require 'todo-comments'.setup({
  highlight = { pattern = [[\s((KEYWORDS)(\(.+\))?):]] },
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
