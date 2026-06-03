vim.pack.add({ 'https://github.com/nvim-lualine/lualine.nvim' })

local hover_cache = ''

require 'lualine'.setup {
  options = {
    globalstatus = true,
    icons_enabled = true,
    section_separators = { left = '|', right = '|' },
    component_separators = { left = '|', right = '|' },
    refresh = { statusline = 200, tabline = 200, winbar = 200, }
  },
  sections = {
    lualine_a = { {
      'mode',
      fmt = function(str)
        if vim.b.visual_multi then
          if vim.g.Vm.extend_mode == 0 then
            return 'VM-CURSOR'
          else
            return 'VM-EXTEND'
          end
        end
        return str
      end,
      color = function()
        if vim.b.visual_multi then
          return { bg = '#FF0100', fg = '#FFFFFF' }
        end
      end,
      separator = { right = '' },
    } },
    lualine_b = { 'branch', 'diff' },
    lualine_c = {
      'diagnostics',
      'filename',
      { 'custom', fmt = function() return hover_cache end },
    },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_z = { {
      'location', separator = { left = '' },
      color = function()
        if vim.b.visual_multi then
          return { bg = '#FF0100', fg = '#FFFFFF' }
        end
      end,
    } }
  },
}
local function get_treesitter_captures(text, bufnr, lang, query_name)
  local should_delete = false
  if not bufnr then
    bufnr = vim.api.nvim_create_buf(true, true)
    vim.api.nvim_buf_set_text(bufnr, 0, 0, 0, 0, { text })
    vim.api.nvim_set_option_value('filetype', vim.bo.filetype, { buf = bufnr })
    should_delete = true
  end

  lang = lang or vim.bo[bufnr].filetype
  query_name = query_name or 'highlights'

  local parser = vim.treesitter.get_parser(bufnr, lang)
  if not parser then return {} end

  local query = vim.treesitter.query.get(lang, query_name)
  if not query then return {} end

  local result = {}

  parser:parse(true)
  parser:for_each_tree(function(tree, _)
    local root = tree:root()
    for id, node, _ in query:iter_captures(root, bufnr, 0, -1) do
      local capture_name = query.captures[id]
      local _, start_col, _, end_col = node:range()
      table.insert(result, {
        capture = capture_name,
        start_col = start_col,
        end_col = end_col,
      })
    end
  end)

  if should_delete then
    vim.api.nvim_buf_delete(bufnr, { force = true })
  end

  return result
end

local function apply_ts_highlights(str, param_start, param_end)
  local captures = get_treesitter_captures(str)
  local highlights = {}
  for i = 1, #str do
    local char = str:sub(i, i)
    if char == '\t' then char = '    ' end
    table.insert(highlights, { text = char, pos = i })
  end

  for _, cap in ipairs(captures) do
    local scol = cap.start_col + 1
    if param_end and param_start and ((scol >= param_start and scol <= param_end) or
          (cap.end_col >= param_start and cap.end_col <= param_end)) then
      goto continue
    end

    for i, h in ipairs(highlights) do
      if h.pos == scol then
        table.insert(highlights, i, { text = '%#@' .. cap.capture .. '#' })
        break
      end
    end

    for i, h in ipairs(highlights) do
      if h.pos == cap.end_col then
        table.insert(highlights, i + 1, { text = '%*' })
        break
      end
    end

    ::continue::
  end

  if param_start and param_end then
    for i, h in ipairs(highlights) do
      if h.pos == param_start then
        table.insert(highlights, i, { text = '%#LspSignatureActiveParameter#' })
        break
      end
    end

    for i, h in ipairs(highlights) do
      if h.pos == param_end then
        table.insert(highlights, i + 1, { text = '%*' })
        break
      end
    end
  end

  return vim.iter(highlights):map(function(x) return x.text end):join('')
end

local function first_hover_line(contents)
  local lines = vim.lsp.util.convert_input_to_markdown_lines(contents or {})
  if not lines then return '' end

  for _, line in ipairs(lines) do
    -- TODO: concat lines after matched line untill the line that divides return values and description
    -- though not sure how well it will work with different language servers
    if not line:match('```') and line:match('%S') then
      return apply_ts_highlights(line, get_treesitter_captures())
    end
  end

  return ''
end

local function pick_signature(sig)
  if not sig or not sig.signatures then return nil end

  local idx = sig.activeSignature
  if type(idx) ~= 'number' then idx = 0 end

  return sig.signatures[idx + 1] or sig.signatures[1]
end

local function format_signature(sig)
  if not sig or not sig.label then return nil end

  local sig_hi = apply_ts_highlights(sig.label)

  if not sig.parameters or #sig.parameters == 0 then
    return sig_hi
  end

  local activeIdx = sig.activeParameter or 0
  local first = sig.parameters[1]
  local active = sig.parameters[activeIdx + 1]

  if (not active or not active.label) or (not first or not first.label) then
    return sig_hi
  end

  local active_start, active_end
  local first_start, first_end
  if type(active.label) == 'table' then
    first_start, first_end = first.label[1], first.label[2]
    active_start, active_end = active.label[1] + 1, active.label[2]
  else
    first_start, first_end = sig.label:find(vim.pesc(first.label))
    active_start, active_end = sig.label:find(vim.pesc(active.label))
  end

  if (not active_start or not active_end) or (not first_start or not first_end) then
    return sig_hi
  end

  local cword         = vim.fn.expand('<cword>')
  local function_name = sig.label:sub(1, first_start - 1)
  if #cword > 1 and function_name:sub(1, first_start - 1):match(vim.pesc(cword)) then
    return sig_hi
  end

  if #sig.label > 100 then
    function_name = function_name:sub(-1) == '(' and function_name or function_name .. '('
    local str = '...'
    local param = sig.label:sub(active_start, active_end)
    local pre_param, post_param
    if activeIdx == 0 then
      pre_param = function_name
      post_param = str .. ')'
    elseif activeIdx == #sig.parameters - 1 then
      pre_param = string.format('%s%s', function_name, str)
      post_param = ')'
    else
      pre_param = string.format('%s%s', function_name, str)
      post_param = str .. ')'
    end
    sig.label = pre_param .. param .. post_param
    active_start = #pre_param + 1
    active_end = active_start + #param - 1
  end

  return apply_ts_highlights(sig.label, active_start, active_end)
end

local function request_lsp_info()
  local params = vim.lsp.util.make_position_params(0, 'utf-8')

  if #vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() }) ~= 0 then
    vim.lsp.buf_request(0, 'textDocument/signatureHelp', params, function(_, sig)
      local s = pick_signature(sig)
      if not s then
        vim.lsp.buf_request(0, 'textDocument/hover', params, function(_, hover)
          if hover and hover.contents then
            hover_cache = first_hover_line(hover.contents)
          else
            hover_cache = ''
          end
        end)
      else
        local formatted = format_signature(s)
        if formatted then
          hover_cache = formatted
        end
      end
    end)
  else
    hover_cache = ''
  end
end

vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorMovedI' }, { callback = request_lsp_info })
