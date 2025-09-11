return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    keymaps = {
      ["<C-h>"] = false,
      ["<C-l>"] = false,
      ["<leader>p"] = false,
      ["<c-p"] = false,
    },
    columns = {
      "icon",
      "permissions",
      "size",
      "mtime",
    },
    constrain_cursor = "name",
    delete_to_trash = true,
    view_options = {
      show_hidden = true,
      natural_order = "fast",
    },
    watch_for_changes = true,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  lazy = false,
  default_file_explorer = true,
  init = function()
    vim.keymap.set("n", "<leader>pv", "<cmd>Oil<cr>")
  end,
}
