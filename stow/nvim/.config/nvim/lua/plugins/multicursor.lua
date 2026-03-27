return {
  {
    'mg979/vim-visual-multi',
    branch = 'master',
    lazy = false,
    init = function()
      vim.g.VM_set_statusline = 0
      vim.g.VM_skip_empty_lines = 1
      vim.g.VM_silent_exit = 1
      vim.g.VM_default_mappings = 0
      vim.g.VM_maps = {
        ["Switch Mode"] = "v",
        ["Run Normal"] = "<leader>n",
        ["Run Visual"] = "<leader>v",
        ["Run Macro"] = "<leader>m",
        ["Find Subword Under"] = "s",
        ["Find Next"] = "<c-n>",
        ["Find Prev"] = "<c-p>",
        ["Add Cursor Down"] = "<C-Down>",
        ["Add Cursor Up"] = "<C-Up>",
        ["Start Regex Search"] = "<leader>/",
        ["Align"] = "<leader>a",
        ["Surround"] = "S",
      }

      vim.keymap.set('n', "<leader>t", "<Plug>(VM-Transpose)")
      vim.keymap.set('n', "<leader>c", "<Plug>(VM-Case-Conversion-Menu)")
      vim.keymap.set('n', "<leader>sa", "<Plug>(VM-Select-All)")
      vim.keymap.set('v', "/", "<Plug>(VM-Visual-Regex)")
      vim.keymap.set('v', "<c-n>", "<Plug>(VM-Visual-Cursors)")
    end,

    config = function()
      vim.cmd('VMTheme codedark')
    end,
  },
}
