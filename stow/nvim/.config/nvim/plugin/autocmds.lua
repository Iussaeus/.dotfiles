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

local disable = vim.api.nvim_create_augroup('no_more_D', {})
vim.api.nvim_create_autocmd({ 'InsertEnter', 'TextChanged' }, {
  group = disable,
  callback = function() vim.diagnostic.enable(false) end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  group = disable,
  callback = function() vim.diagnostic.enable() end
})

vim.api.nvim_create_autocmd('BufWinEnter', {
  callback = function() if vim.treesitter.get_parser() then vim.treesitter.start() end end
})

vim.api.nvim_create_autocmd('CursorMoved', {
  callback = function() vim.cmd 'normal! zzzv' end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.hl.on_yank { higroup = 'CurSearch', timeout = 200 } end
})
