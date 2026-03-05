return {
  {
    "Iussaeus/ido-mode.nvim",
    config = function()
      local ido = require 'ido-mode'.setup()
      vim.keymap.set("c", "<cr>", function() ido:enter() end)
      vim.keymap.set("c", "<c-t>", function() ido:toggle() end)
      vim.keymap.set("c", "<c-n>", function() ido:next_suggestion() end)
      vim.keymap.set("c", "<c-p>", function() ido:previous_suggestion() end)
      vim.keymap.set("c", "<c-y>", function() ido:accept_suggestion() end)
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
