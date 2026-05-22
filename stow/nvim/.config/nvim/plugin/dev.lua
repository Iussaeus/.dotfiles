local dev_directory = '~/code'
local remote = 'https://github.com/'

-- todo: support all vim.pack.add params
local function packadd(pkg)
  local dev_directory = vim.fs.abspath(dev_directory)
  if not dev_directory then
    error(string.format('packadd: %s is not a valid dev directory', dev_directory))
  end

  local stat = vim.uv.fs_stat(dev_directory)
  if not stat or stat.type ~= 'directory' then
    error(string.format('packadd: %s is not a valid dev directory', dev_directory))
  end

  local pkg_split = vim.split(pkg, '/', { trimempty = true, plain = true })
  local pkg_name
  if #pkg_split ~= 2 then
    vim.print(pkg_split)
    error(string.format('packadd: package should have the next form "author/package" %q', pkg))
  else
    pkg_name = pkg_split[2]
  end

  local pkg_dev_path = vim.fs.joinpath(dev_directory, pkg_name)
  stat = vim.uv.fs_stat(pkg_dev_path)
  if stat then
    if stat.type == 'directory' then
      pkg = '/compile.nvim'
      local pkg_vim_dir = vim.fs.joinpath(vim.fn.stdpath('data'), 'site', 'pack', 'dev', 'opt')
      stat = vim.uv.fs_stat(pkg_vim_dir)
      if not stat then
        local ok, err = pcall(vim.fn.mkdir, pkg_vim_dir, 'p')
        if not ok then
          error(string.format('packadd: err while mkdir %q: %s', pkg_vim_dir, err))
        end
      end
      local pkg_vim_path = vim.fs.joinpath(pkg_vim_dir, pkg_name)
      stat = vim.uv.fs_stat(pkg_vim_path)
      if not stat then
        local ok, err, err_name = vim.uv.fs_symlink(pkg_dev_path, pkg_vim_path)
        if not ok then
          error(string.format('packadd: err %s while linking %q to %q: %s', err_name, pkg_dev_path, pkg_vim_path, err))
        end

        vim.notify(string.format('packadd: linked %q to %q', pkg_dev_path, pkg_vim_path), vim.log.levels.INFO)
      end

      vim.cmd.packadd(pkg_name)
    else
      error(string.format('packadd: %q is not a directory', pkg_dev_path))
    end
  else
    vim.notify(string.format('packadd: downloading %q from remote %q using vim.pack', pkg, remote))
    vim.pack.add({ vim.fs.joinpath(remote, package) })
  end
end

packadd('Iussaeus/ido-mode.nvim')
vim.keymap.set("c", "<c-t>", require 'ido-mode'.toggle)
vim.keymap.set("c", "<c-n>", require 'ido-mode'.next_suggestion)
vim.keymap.set("c", "<c-p>", require 'ido-mode'.previous_suggestion)
vim.keymap.set("c", "<c-y>", require 'ido-mode'.accept_suggestion)

packadd('Iussaeus/goback.nvim')
vim.keymap.set("n", "<a-b>", require 'goback'.go_back, { remap = true })
vim.keymap.set("n", "<a-f>", require 'goback'.go_forth, { remap = true })

packadd('Iussaeus/sessman.nvim')
vim.keymap.set("n", "<a-s>", require 'sessman'.show_sessions, { remap = true })

packadd('Iussaeus/compile.nvim')
vim.keymap.set("n", "<leader>cc", require 'compile'.compile)
vim.keymap.set("n", "<leader>cn", require 'compile'.jump_to_next)
vim.keymap.set("n", "<leader>cp", require 'compile'.jump_to_prev)
vim.keymap.set("n", "<leader>rcc", require 'compile'.recompile)

-- packadd('Iussaeus/cursors.nvim')
-- vim.keymap.set("n", "<leader>nc", require 'cursors'.find_under_cursor)
-- vim.keymap.set("n", "<leader>cs", require 'cursors'.stop)
