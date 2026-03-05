return {
  'folke/todo-comments.nvim',
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local todo = require 'todo-comments'

    todo.setup({
      keywords = {
        TODO = { icon = " ", color = "info", alt = { "todo", "Todo" }},
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX", "warn", "warning", "xxx", "Warn", "Warning" }},
        NOTE = { icon = " ", color = "hint", alt = { "INFO", "info" }},
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED", "testing", "passed", "failed", "Testing", "Passed", "Failed" }},
        FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "fix", "fixme", "bug", "fixit", "Fix", "Issue", "Fixme", "Bug", "Fixit", "Issue" }},
      }
    })
    vim.keymap.set("n", "<leader>tdf", "<cmd>TodoTelescope<cr>")
    vim.keymap.set("n", "<leader>tdl", "<cmd>TodoLocList<cr>")
  end
}
