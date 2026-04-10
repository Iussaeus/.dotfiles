vim.g.VM_set_statusline = 0
vim.g.VM_skip_empty_lines = 1
vim.g.VM_silent_exit = 1
vim.g.VM_default_mappings = 0
vim.g.VM_maps = {
  ["Find Under"] = "",
  ["Find Subword Under"] = "",
  ["Exit"] = "q",
  ["Switch Mode"] = "v",
  ["Toggle Multiline"] = "V",
  ["Run Normal"] = "gn",
  ["Run Visual"] = "gv",
  ["Run Macro"] = "gm",
  ["Seek Next"] = "n",
  ["Find Next"] = "<c-n>",
  ["Find Prev"] = "<c-p>",
  ["Add Cursor Down"] = "<C-Down>",
  ["Add Cursor Up"] = "<C-Up>",
  ["Align"] = "<m-a>",
  ["Align Regex"] = "<c-r>",
  ["Surround"] = "S",
}

vim.pack.add({ 'https://github.com/mg979/vim-visual-multi' })

vim.keymap.set('n', "<leader>sa", "<Plug>(VM-Select-All)")
vim.keymap.set('n', "<c-t>", "<Plug>(VM-Transpose)")
vim.keymap.set('n', "<c-c>", "<Plug>(VM-Case-Conversion-Menu)")
vim.keymap.set('v', "/", "<Plug>(VM-Visual-Regex)")
vim.keymap.set({ 'n', 'v' }, "<c-/>", "<Plug>(VM-Start-Regex-Search)")
vim.keymap.set('n', '<esc>', function()
  if not vim.b.visual_multi then
    return '<esc>'
  end

  if vim.g.Vm.extend_mode == 1 then
    return '<Plug>(VM-Switch-Mode)'
  else
    return '<Plug>(VM-Exit)'
  end
end, { expr = true, silent = true })

vim.keymap.set({ 'n', 'v' }, "<c-n>", function()
  local mode = vim.fn.mode()
  if mode == 'n' then
    return "<Plug>(VM-Find-Under)"
  elseif mode == 'v' then
    return "<Plug>(VM-Find-Subword-Under)"
  elseif mode == 'V' or mode == '' then
    return "<Plug>(VM-Visual-Cursors)"
  end
end, { expr = true, silent = true })

vim.cmd('VMTheme codedark')
