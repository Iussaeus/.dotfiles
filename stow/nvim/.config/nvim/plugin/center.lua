-- bug: on ':e' it can shift the cursor by 1 line and at the end of the file it centers the cursor
-- bug: sometimes when entering insert mode the cursor can shift by one line just before the mode was entered, but can't reproduce realiably

local ignore_fts = { 'nvim-undotree' }

local pasting = false
vim.paste = (function(overridden)
  return function(lines, phase)
    if phase == 1 or phase == -1 then pasting = true end
    if phase == 2 then pasting = false end
    return overridden(lines, phase)
  end
end)(vim.paste)

-- center cursors, doing ZZ constantly is janky and does not handle scrolls
vim.api.nvim_create_autocmd('WinScrolled', {
  callback = function()
    if vim.tbl_contains(ignore_fts, vim.bo.filetype) then return end
    if pasting then
      pasting = false
      return
    end

    local first = vim.fn.line('w0')
    local height = vim.api.nvim_win_get_height(0)
    local half_height = math.floor(height / 2)
    local middle_row = first + half_height
    local cursor = vim.api.nvim_win_get_cursor(0)
    local lines = vim.api.nvim_buf_line_count(0)

    if cursor[1] == middle_row or (cursor[1] > 0 and cursor[1] <= height / 2)
        or (cursor[1] >= lines - half_height and cursor[1] <= lines - half_height) then
      return
    end

    pcall(vim.api.nvim_win_set_cursor, 0, { middle_row, cursor[2] })
  end,
})

vim.api.nvim_create_autocmd('CursorMoved', {
  callback = function()
    if vim.tbl_contains(ignore_fts, vim.bo.filetype) then return end
    if pasting then
      pasting = false
      return
    end

    local first = vim.fn.line('w0')
    local height = vim.api.nvim_win_get_height(0)
    local half_height = math.floor(height / 2)
    local middle_row = first + half_height
    local cursor = vim.api.nvim_win_get_cursor(0)
    local topline = math.max(1, cursor[1] - half_height)

    if cursor[1] == middle_row or (cursor[1] > 0 and cursor[1] < half_height) then
      return
    end

    pcall(vim.fn.winrestview, { topline = topline, cursor = cursor })
  end,
})
