vim.api.nvim_create_user_command("Term", function(args)
  vim.cmd [[split]]
  vim.cmd("terminal " .. table.concat(args.fargs, " "))
end, { nargs = '*' })
