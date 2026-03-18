return {
  {
    "Iussaeus/ido-mode.nvim",
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
}
