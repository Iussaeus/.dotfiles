-- todo: check if plugin exists as file:// then use https://
local dir_url = vim.fn.join({'file://', vim.env.HOME, 'code'}, '/')
local gh_url = 'https://github.com/Iussaeus'

local pack_add = function(pack)
  local url = vim.fn.join({ dir_url, pack }, '/')
  local ok, _ = pcall(vim.pack.add, {url})
  if not ok then
    url = vim.fn.join({ gh_url, pack }, '/')
    vim.pack.add({ url })
  end
end

pack_add('ido-mode.nvim')
vim.keymap.set("c", "<c-t>", require 'ido-mode'.toggle)
vim.keymap.set("c", "<c-n>", require 'ido-mode'.next_suggestion)
vim.keymap.set("c", "<c-p>", require 'ido-mode'.previous_suggestion)
vim.keymap.set("c", "<c-y>", require 'ido-mode'.accept_suggestion)

pack_add('goback.nvim')
vim.keymap.set("n", "<a-b>", require 'goback'.go_back, { remap = true })
vim.keymap.set("n", "<a-f>", require 'goback'.go_forth, { remap = true })

pack_add('compile.nvim')
vim.keymap.set("n", "<leader>cc", require 'compile'.compile)
vim.keymap.set("n", "<leader>cn", require 'compile'.jump_to_next)
vim.keymap.set("n", "<leader>cp", require 'compile'.jump_to_prev)
vim.keymap.set("n", "<leader>cf", require 'compile'.compile_fwd)
vim.keymap.set("n", "<leader>rcc", require 'compile'.recompile)

pack_add('cursors.nvim')
vim.keymap.set("n", "<leader>nc", require 'cursors'.find_under_cursor)
vim.keymap.set("n", "<leader>cs", require 'cursors'.stop)
