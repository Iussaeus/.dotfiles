-- when in insert mode show no diganostics, toggle them on on save, just like rust lsp does
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
  callback = function()
    if vim.fs.ext(vim.api.nvim_buf_get_name(0)) == 'log' then vim.cmd [[set filetype=log]] end
  end
})

-- start treesitter if parser is available
vim.api.nvim_create_autocmd('BufWinEnter', {
  callback = function()
    local parser = vim.treesitter.get_parser()
    if parser then vim.treesitter.highlighter.new(parser) end
  end
})

-- add quit keymap to selected filetypes
vim.api.nvim_create_autocmd('BufWinEnter', {
  callback = function()
  end
})

-- add window rules selected filetypes
vim.api.nvim_create_autocmd('BufWinEnter', {
  callback = function()
    if vim.tbl_contains({ 'help', 'man', 'fugitive', 'qf' }, vim.bo.filetype) then
      vim.keymap.set('n', 'q', function() vim.api.nvim_win_close(0, true) end, { buffer = 0, nowait = true })
    end

    if vim.tbl_contains({ 'help', 'man', 'fugitive' }, vim.bo.filetype) then
      vim.api.nvim_win_set_config(0, {
        width = 85,
        split = 'right',
        vertical = true,
      })

      vim.wo.winfixheight = true
      vim.wo.winfixwidth = true
      vim.wo.sidescrolloff = 0
    end
  end
})

-- highlight yank area
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.hl.on_yank { higroup = 'CurSearch', timeout = 200 } end
})
