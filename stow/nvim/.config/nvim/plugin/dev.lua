local function add_local_package(pkg, opts)
  opts = opts or {}
  opts.dev_directory = opts.dev_directory or '~/code'
  opts.remote = opts.remote or 'https://github.com/'
  local dev_directory = vim.fs.abspath(opts.dev_directory)
  if not dev_directory then
    error(('add_local_package: %s is not a valid dev directory'):format(dev_directory))
  end

  local stat = vim.uv.fs_stat(dev_directory)
  if not stat or stat.type ~= 'directory' then
    error(('add_local_package: %s is not a valid dev directory'):format(dev_directory))
  end

  local pkg_split = vim.split(pkg, '/', { trimempty = true, plain = true })
  local pkg_name
  if #pkg_split ~= 2 then
    error(('add_local_package: package should have the next form "author/package", but got %q'):format(pkg))
  else
    pkg_name = pkg_split[2]
  end

  local pkg_dev_path = vim.fs.joinpath(dev_directory, pkg_name)
  stat = vim.uv.fs_stat(pkg_dev_path)
  if stat then
    if stat.type == 'directory' then
      local pkg_vim_dir = vim.fs.joinpath(vim.fn.stdpath('data'), 'site', 'pack', 'dev', 'opt')
      if not vim.uv.fs_stat(pkg_vim_dir) then
        local ok, err = pcall(vim.fn.mkdir, pkg_vim_dir, 'p')
        if not ok then
          error(('add_local_package: err while mkdir %q: %s'):format(pkg_vim_dir, err))
        end
      end
      local pkg_vim_path = vim.fs.joinpath(pkg_vim_dir, pkg_name)
      if not vim.uv.fs_stat(pkg_vim_path) then
        local ok, err, err_name = vim.uv.fs_symlink(pkg_dev_path, pkg_vim_path)
        if not ok then
          error(('add_local_package: err %s while linking %q to %q: %s'):format(err_name, pkg_dev_path,
            pkg_vim_path, err))
        end

        vim.notify(('add_local_package: linked %q to %q'):format(pkg_dev_path, pkg_vim_path), vim.log.levels.INFO)
      end

      if pcall(vim.pack.get, { pkg_name }) then vim.pack.del({ pkg_name }, { force = true }) end

      vim.cmd.packadd(pkg_name)
    else
      error(('add_local_package: %q is not a directory'):format(pkg_dev_path))
    end
  else
    if opts.remote:sub(-1) ~= '/' then
      opts.remote = opts.remote .. '/'
    end

    vim.pack.add({ opts.remote .. pkg })
  end
end

add_local_package('Iussaeus/ido-mode.nvim')
vim.keymap.set("c", "<c-t>", require 'ido-mode'.toggle)
vim.keymap.set("c", "<c-n>", require 'ido-mode'.next_suggestion)
vim.keymap.set("c", "<c-p>", require 'ido-mode'.previous_suggestion)
vim.keymap.set("c", "<c-y>", require 'ido-mode'.insert_current_suggestion)

add_local_package('Iussaeus/goback.nvim')
vim.keymap.set("n", "<a-b>", require 'goback'.go_back)
vim.keymap.set("n", "<a-f>", require 'goback'.go_forth)

add_local_package('Iussaeus/sessman.nvim')
vim.keymap.set("n", "<a-s>", require 'sessman'.open_session_buf)
vim.keymap.set("n", "<leader>ss", require 'sessman'.start_session)
vim.keymap.set("n", "<leader>so", require 'sessman'.stop_session)

add_local_package('Iussaeus/compile.nvim')
vim.keymap.set("n", "<leader>cc", require 'compile'.compile)
vim.keymap.set("n", "<leader>cn", require 'compile'.jump_to_next)
vim.keymap.set("n", "<leader>cp", require 'compile'.jump_to_prev)
vim.keymap.set("n", "<leader>rcc", require 'compile'.recompile)
vim.keymap.set('n', '<leader>co', require 'compile'.open_job_buf)
vim.keymap.set('n', '<a-c>', require 'compile'.open_compile_buf)

-- packadd('Iussaeus/cursors.nvim')
-- vim.keymap.set("n", "<leader>nc", require 'cursors'.find_under_cursor)
-- vim.keymap.set("n", "<leader>cs", require 'cursors'.stop)
