return {
  {
    "Iussaeus/ido-mode.nvim",
    dir = '~/code/ido-mode.nvim',
    init = function()
      vim.keymap.set("c", "<c-t>", require 'ido-mode'.toggle)
      vim.keymap.set("c", "<c-n>", require 'ido-mode'.next_suggestion)
      vim.keymap.set("c", "<c-p>", require 'ido-mode'.previous_suggestion)
      vim.keymap.set("c", "<c-y>", require 'ido-mode'.accept_suggestion)
    end
  },
  {
    "Iussaeus/goback.nvim",
    init = function()
      vim.keymap.set("n", "<leader>gb", require 'goback'.go_back)
      vim.keymap.set("n", "<leader>gf", require 'goback'.go_forth)
    end
  },
  {
    "Iussaeus/compile.nvim",
    dir = '~/code/compile.nvim',
    init = function()
      vim.keymap.set("n", "<leader>cc", require 'compile'.compile)
      vim.keymap.set("n", "<leader>cn", require 'compile'.jump_to_next)
      vim.keymap.set("n", "<leader>cp", require 'compile'.jump_to_prev)
      vim.keymap.set("n", "<leader>cf", require 'compile'.compile_fwd)
      vim.keymap.set("n", "<leader>rcc", require 'compile'.recompile)
    end,
  },
}
