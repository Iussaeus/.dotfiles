vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = false

vim.keymap.set("n", "<leader>en", "oif err != nil {<CR>return err<CR>}<ESC>k_v$h")
vim.keymap.set("n", "<leader>enp", "oif err != nil {<CR>fmt.Printf(\"Err: %s\", err)<CR>}<ESC>")

vim.api.nvim_create_user_command('Go', function(opts)
  local lines = vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, false)
  if #lines == 1 and lines[1] == '' then
    vim.notify('no lines selected', vim.log.levels.ERROR)
    return
  end

  table.insert(lines, 1, 'package main')
  table.insert(lines, 2, 'func main() {')
  table.insert(lines, '}')

  local file = assert(io.open('/tmp/go-playground.go', 'w+'), 'where file?')
  file:write(table.concat(lines, '\n'))
  file:flush()

  local job_buf = vim.api.nvim_create_buf(false, true)
  vim.keymap.set('n', 'q', '<cmd>q<cr>', { buffer = job_buf, remap = true, nowait = true })
  local job_id
  vim.keymap.set('n', '<c-c>', function() vim.fn.jobstop(job_id) end, { buffer = job_buf, remap = true, nowait = true })
  vim.fn.jobstart('gopls codeaction -exec -kind=source.organizeImports -write /tmp/go-playground.go', {
    on_exit = function()
      vim.api.nvim_open_win(job_buf, true, { anchor = 'SW', height = 15, split = 'below', })
      job_id = vim.fn.jobstart('go run /tmp/go-playground.go', { term = true })
    end
  })
end, {
  desc = "Run go code",
  range = true,
})
