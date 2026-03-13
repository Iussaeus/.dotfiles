return {
  {
    "Iussaeus/ido-mode.nvim",
    dir = "~/code/ido-mode.nvim",
    init = function()
      vim.keymap.set("c", "<c-t>", function() require 'ido-mode'.toggle() end)
      vim.keymap.set("c", "<c-n>", function() require 'ido-mode'.next_suggestion() end)
      vim.keymap.set("c", "<c-p>", function() require 'ido-mode'.previous_suggestion() end)
      vim.keymap.set("c", "<c-y>", function() require 'ido-mode'.accept_suggestion() end)
    end
  },
  {
    "Iussaeus/goback.nvim",
    config = function()
      local goback = require 'goback'.setup()
      vim.keymap.set("n", "<leader>gb", function() goback:one_level_back() end)
      vim.keymap.set("n", "<leader>gf", function() goback:one_level_forth() end)
    end
  },
}
