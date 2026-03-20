return {
  "ej-shafran/compile-mode.nvim",
  vesion = "5.*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "m00qek/baleia.nvim", tag = "v1.3.0" },
  },
  config = function()
    vim.g.compile_mode = {
      baleia_setup = true,
      use_diagnostics = true,
      default_command = "",
    }

    local split_opts = "botright 15"

    vim.keymap.set("n", "<leader>cm", '<cmd>' .. split_opts .. ' Compile<cr>')
    vim.keymap.set("n", "<leader>rc", require 'compile-mode'.recompile)

    vim.keymap.set("n", "<leader>cn", require 'compile-mode'.next_error)
    vim.keymap.set("n", "<leader>cp", require 'compile-mode'.prev_error)
  end,
}
