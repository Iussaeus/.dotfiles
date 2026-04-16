-- todo: function that checks if the plugin exists in project directory if exists
-- it copies the plugin to vim/pack/*/start, else uses vim.pack.add with a 

-- vim.pack.add({'https://github.com/Iussaeus/ido-mode.nvim'})
vim.keymap.set("c", "<c-t>", require 'ido-mode'.toggle)
vim.keymap.set("c", "<c-n>", require 'ido-mode'.next_suggestion)
vim.keymap.set("c", "<c-p>", require 'ido-mode'.previous_suggestion)
vim.keymap.set("c", "<c-y>", require 'ido-mode'.accept_suggestion)

-- vim.pack.add({'https://github.com/Iussaeus/goback.nvim'})
vim.keymap.set("n", "<a-b>", require 'goback'.go_back, { remap = true })
vim.keymap.set("n", "<a-f>", require 'goback'.go_forth, { remap = true })

-- vim.pack.add({'https://github.com/Iussaeus/compile.nvim'})
vim.keymap.set("n", "<leader>cc", require 'compile'.compile)
vim.keymap.set("n", "<leader>cn", require 'compile'.jump_to_next)
vim.keymap.set("n", "<leader>cp", require 'compile'.jump_to_prev)
vim.keymap.set("n", "<leader>cf", require 'compile'.compile_fwd)
vim.keymap.set("n", "<leader>rcc", require 'compile'.recompile)

-- vim.pack.add({'https://github.com/Iussaeus/cursors.nvim'})
vim.keymap.set("n", "<leader>nc", require 'cursors'.find_under_cursor)
vim.keymap.set("n", "<leader>cs", require 'cursors'.stop)
