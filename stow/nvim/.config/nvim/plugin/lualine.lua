vim.pack.add({ 'https://github.com/nvim-lualine/lualine.nvim' })

local hover_cache = ""

local function get_treesitter_captures(text, bufnr, lang, query_name)
  local should_delete = false
  if not bufnr then
    bufnr = vim.api.nvim_create_buf(true, true)
    vim.api.nvim_buf_set_text(bufnr, 0, 0, 0, 0, {text})
    vim.api.nvim_set_option_value('filetype', vim.bo.filetype,{ buf = bufnr})
    should_delete = true
  end

  lang = lang or vim.bo[bufnr].filetype
  query_name = query_name or "highlights"

  local parser = vim.treesitter.get_parser(bufnr, lang)
  if not parser then return {} end

  local query = vim.treesitter.query.get(lang, query_name)
  if not query then return {} end

  local result = {}

  parser:parse(true)
  parser:for_each_tree(function (tree, _)
    local root = tree:root()
    for id, node, _ in query:iter_captures(root, bufnr, 0, -1) do
      local capture_name = query.captures[id]
      local start_row, start_col, end_row, end_col = node:range()
      table.insert(result, {
        capture = capture_name,
        range   = { start_row, start_col, end_row, end_col },
      })
    end
  end)

  if should_delete then
    vim.api.nvim_buf_delete(bufnr, {force = true})
  end

  return result
end

local function apply_ts_highlights(str, current_param)
  local captures = get_treesitter_captures(str)
  -- note: another idea is to copy the string into a list that contains tables with the structure { char = 'c', pos = 5 }
  -- and insert the highlights before pos == capture.range[2] + 1 and insert the '%*' after pos == capture.range[4]
  -- so the result will look like this { "%#@operator#", { char = '+', pos = 1 }, '%*'}
  -- this solution is heavier memory-wise but will preserve the spaces, bars and whatnot
  local highlights = {}
  local count = 0
  local skip = false
  local looking = true
  for i, c in ipairs(captures) do
    local hl = "@" .. c.capture

    local scol = c.range[2] + 1
    local ecol = c.range[4]
    local symbol = str:sub(scol, ecol)
    local suffix = str:sub(scol, ecol+1):sub(-1) ~= " " and "" or " "

    local next = captures[i + 1]
    local next_symbol
    if next then
      next_symbol = str:sub(next.range[2] + 1, next.range[4])
    end

    local prev = captures[i - 1]
    local prev_symbol
    if prev then
      prev_symbol = str:sub(prev.range[2] + 1, prev.range[4])
    end

    -- print(string.format("symbol: %q, suffix: %q prev: %q next: %q, hl:%q", symbol, suffix, prev_symbol, next_symbol, hl))
    if skip then
      skip = false
      goto continue
    end

    if not prev or prev_symbol == symbol then
      table.insert(highlights, "%#" .. hl .. "#")
      count = count + 1
    end

    -- todo: check symbol + next_symbols right now things like go variadics "arg ...type" or pointers "*type" or slices "[]type"
    -- do not match since next_symbol is an operator or other type of object
    -- note: this does not work if a symbol is not a capture maybe we should use view into str and shrink it as we traverse
    -- captures and insert what was not captured
    if looking and next and symbol..suffix..next_symbol == current_param then
      table.insert(highlights, "%#LspSignatureActiveParameter#")
      table.insert(highlights, symbol..suffix..next_symbol)
      table.insert(highlights, "%*")
      skip = true
      looking = false
      goto continue
    end

    -- note: if a symbol is not a capture it will not be inserted for example in lua if the signature
    -- begins with "function string.rep(s number|string, ...)" it will result in "function string.rep(s numberstring, ...)" 
    -- bug: case when next_symbol == symbol is not handled so it results in two copies of symbol
    if symbol == prev_symbol and next ~= symbol or symbol == prev_symbol then
      table.insert(highlights, symbol .. suffix)
    elseif symbol ~= prev_symbol and symbol ~= next_symbol then
      table.insert(highlights, "%#" .. hl .. "#")
      table.insert(highlights, symbol .. suffix)
      table.insert(highlights, "%*")
      goto continue
    end

    if not next or next_symbol ~= symbol then
      table.insert(highlights, string.rep("%*", count))
      count = 1
    end
    ::continue::
  end

  -- for i, h in pairs(highlights) do
  --   print(i, h)
  -- end

  return table.concat(highlights)
end

local function first_hover_line(contents)
  local lines = vim.lsp.util.convert_input_to_markdown_lines(contents or {})
  if not lines then return "" end

  for _, line in ipairs(lines) do
    if not line:match("```") and line:match("%S") then
      return apply_ts_highlights(line, get_treesitter_captures())
    end
  end

  return ""
end

local function pick_signature(sig)
  if not sig or not sig.signatures then return nil end

  local idx = sig.activeSignature
  if type(idx) ~= "number" then idx = 0 end

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

  local active_start, active_finish
  local first_start, first_finish
  if type(active.label) == "table" then
    first_start = first.label[1]
    first_finish = first.label[2]

    active_start = active.label[1]
    active_finish = active.label[2]
  else
    first_start, first_finish = sig.label:find(vim.pesc(first.label))
    active_start, active_finish = sig.label:find(vim.pesc(active.label))
  end

  if (not active_start or not active_finish) or (not first_start or not first_finish) then
    return sig_hi
  end

  local cword          = vim.fn.expand('<cword>')
  local function_name  = sig.label:sub(1, first_start - 1)
  local prev_params    = sig.label:sub(first_start, active_start - 1)
  local current_param  = sig.label:sub(active_start, active_finish)
  local rest           = sig.label:sub(active_finish + 1)

  if function_name:sub(1, first_start - 1):match(vim.pesc(cword)) then
    return sig_hi
  end

  local signature = function_name .. prev_params .. current_param .. rest

  return apply_ts_highlights(signature, current_param)
end

local function request_lsp_info()
  local params = vim.lsp.util.make_position_params(0, 'utf-8')

  vim.lsp.buf_request(0, "textDocument/signatureHelp", params, function(_, sig)
    local s = pick_signature(sig)
    if not s then
      vim.lsp.buf_request(0, "textDocument/hover", params, function(_, hover)
        if hover and hover.contents then
          hover_cache = first_hover_line(hover.contents)
        else
          hover_cache = ""
        end
        vim.cmd("redrawstatus")
      end)
      return
    end

    local formatted = format_signature(s)
    if formatted then
      hover_cache = formatted
      vim.cmd("redrawstatus")
    end
  end)

end

vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  callback = request_lsp_info,
})

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
      {
        'custom',
        fmt = function()
          return hover_cache
        end,
      },
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
