return {
  "ej-shafran/compile-mode.nvim",
  vesion = "5.*",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    vim.g.compile_mode = {
      default_command = "",
    }

    vim.keymap.set("n", "<leader>cm", '<cmd>Compile<cr>')
    vim.keymap.set("n", "<leader>rcm", '<cmd>Recompile<cr>')
    vim.keymap.set("n", "<leader>cmn", '<cmd>NextError<cr>')
    vim.keymap.set("n", "<leader>cmp", '<cmd>PrevError<cr>')
  end,
}
