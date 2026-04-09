vim.opt_local.expandtab = true
vim.opt_local.softtabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4

vim.lsp.enable('omnisharp')

-- map[script]scene
local scene = {}
local run_gd_scene = function()
  local filename = vim.fn.expand('%:t') .. ".uid"
  local uid_path = vim.fs.find({ filename }, { limit = math.huge, type = 'file', path = vim.fn.getcwd() })[1]

  if not uid_path then
    vim.notify("No uid found.", vim.log.levels.ERROR)
    return
  end

  local scene_path = ""
  if scene[uid_path] == nil then
    local file = io.open(uid_path, "r")
    local uid = file:read("l")
    file:close()

    local cmd = 'grep ' ..
        uid ..
        ' --recursive ' ..
        '--files-with-matches ' ..
        '--exclude "project.godot" ' ..
        '--exclude-dir ".git/" --exclude-dir ".godot/" --exclude-dir "bin/" ' ..
        '--exclude "' .. vim.fn.fnamemodify(uid_path, ":t") .. '"'

    scene_path = vim.fn.system(cmd):gsub("\n", "")
    scene[uid_path] = scene_path
    if uid_path == "" then
      vim.notify("No scene found.", vim.log.levels.ERROR)
      return
    end
  else
    scene_path = scene[uid_path]
  end

  vim.cmd('split')
  vim.cmd('terminal dotnet build && godot-mono -d --path "' .. vim.fn.getcwd() .. '" --scene "' .. scene_path .. '"')
end

-- TODO: maybe a more persistent caching
-- TODO: maybe a version for gdscript
local main_scene_path_cached = ""
local run_gd_project = function()
  local main_scene_path = ""

  if main_scene_path_cached == "" then
    local file = io.open(vim.fn.getcwd() .. '/project.godot', "r")
    local main_scene_uid = file:read("a"):match('run/main_scene="(.-)"\n')
    file:close()
    if main_scene_uid == nil then
      vim.notify("No main scene found.", vim.log.levels.ERROR)
      return
    end

    local cmd = 'grep ' ..
        main_scene_uid ..
        ' --recursive ' ..
        '--files-with-matches ' ..
        '--exclude "project.godot" ' ..
        '--exclude-dir ".git/" --exclude-dir ".godot/" --exclude-dir "bin/" '

    main_scene_path = vim.fn.system(cmd):gsub("\n", "")
    main_scene_path_cached = main_scene_path
  else
    main_scene_path = main_scene_path_cached
  end

  vim.cmd('split')
  vim.cmd('terminal dotnet build && godot-mono -d --path "' .. vim.fn.getcwd() .. '" --scene "' .. main_scene_path .. '"')
end

if vim.uv.fs_stat(vim.fn.getcwd() .. '/project.godot') then
  vim.keymap.set('n', '<leader>rs', run_gd_scene)
  vim.keymap.set('n', '<leader>rp', run_gd_project)
end
