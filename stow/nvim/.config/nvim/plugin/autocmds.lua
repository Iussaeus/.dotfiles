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
    if vim.treesitter.get_parser() then vim.treesitter.start() end
  end
})

vim.api.nvim_create_autocmd('BufWinEnter', {
  callback = function()
    if vim.fs.ext(vim.api.nvim_buf_get_name(0)) == 'log' then vim.cmd [[set filetype=log]] end
  end
})

vim.api.nvim_create_autocmd('InsertEnter', {
  callback = function()
    if vim.bo.filetype == 'TelescopePrompt' then vim.bo.autocomplete = false end
  end
})

vim.api.nvim_create_autocmd('WinScrolled', {
  callback = function()
    if vim.bo.filetype == 'nvim-undotree' then return end

    local first = vim.fn.line('w0')
    local height = vim.api.nvim_win_get_height(0)
    local middle_row = first + math.floor((height) / 2)
    local cursor = vim.api.nvim_win_get_cursor(0)

    if cursor[1] == middle_row or (cursor[1] > 0 and cursor[1] <= height / 2) then
      return
    end

    pcall(vim.api.nvim_win_set_cursor, 0, { middle_row, cursor[2] })
  end,
})

vim.api.nvim_create_autocmd('CursorMoved', {
  callback = function()
    if vim.bo.filetype == 'nvim-undotree' then return end

    local first = vim.fn.line('w0')
    local height = vim.api.nvim_win_get_height(0)
    local middle_row = first + math.floor((height) / 2)
    local cursor = vim.api.nvim_win_get_cursor(0)
    local topline = math.max(1, cursor[1] - math.floor(height / 2))

    if cursor[1] == middle_row or (cursor[1] > 0 and cursor[1] < height / 2) then
      return
    end

    -- todo: handle errors
    pcall(vim.fn.winrestview, { topline = topline, cursor = { cursor[1], cursor[2] } })
  end,
})

vim.api.nvim_create_autocmd('BufWinEnter', {
  callback = function()
    if vim.tbl_contains({ 'help', 'man', 'fugitive', 'qf' }, vim.bo.filetype) then
      vim.keymap.set('n', 'q', function() vim.api.nvim_win_close(0, true) end, { buffer = 0, nowait = true })
    end
  end
})

vim.api.nvim_create_autocmd('BufWinEnter', {
  callback = function()
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

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.hl.on_yank { higroup = 'CurSearch', timeout = 200 } end
})
