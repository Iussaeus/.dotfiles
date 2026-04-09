local sized_filetypes = { 'help', 'man', 'fugitive' }
vim.api.nvim_create_autocmd('BufWinEnter', {
  callback = function()
    local filetype = vim.api.nvim_get_option_value('filetype', { buf = 0 })
    if vim.tbl_contains(sized_filetypes, filetype) then
      vim.keymap.set('n', 'q', function() vim.api.nvim_win_close(0, true) end, { buffer = 0, nowait = true })
      vim.cmd 'wincmd L'
      vim.cmd 'wincmd 25<'
      vim.cmd 'set winfixheight'
    end
  end
})

vim.api.nvim_create_autocmd('BufWinEnter', {
  pattern = { [[\*compilation\*]] },
  callback = function()
    vim.keymap.set('n', 'q', function() vim.api.nvim_win_close(0, true) end, { buffer = 0, nowait = true })
    vim.cmd 'wincmd J'
    vim.cmd 'resize 20'
    vim.cmd 'set winfixheight'
  end
})

local disable = vim.api.nvim_create_augroup('no_more_D', {})
vim.api.nvim_create_autocmd({'InsertEnter', 'TextChanged'}, {
  group = disable,
  callback = function()
    vim.diagnostic.enable(false)
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  group = disable,
  callback = function()
    vim.diagnostic.enable()
  end
})

vim.api.nvim_create_autocmd('CursorMoved', {
  group = disable,
  callback = function()
    vim.diagnostic.enable()
  end
})

vim.api.nvim_create_autocmd('CursorMoved', {
  group = disable,
  callback = function()
    if #vim.api.nvim_buf_get_lines(0, 0, -1, false) - vim.fn.line '.' < vim.o.scrolloff then
      vim.cmd 'normal! zzzv'
    end
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.hl.on_yank { higroup = 'CurSearch', timeout = 300 }
  end
})
