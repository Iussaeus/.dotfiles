vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help", "man", "fugitive" },
  callback = function()
    vim.cmd "set winfixheight"
    vim.cmd "set winfixheight"
    vim.cmd "wincmd L"
    vim.cmd "wincmd 25<"
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "*compilation*" },
  callback = function()
    vim.cmd "set winfixheight"
    vim.cmd "set winfixheight"
    vim.cmd "wincmd J"
    vim.cmd "resize 20"
  end
})


vim.api.nvim_create_autocmd("TermOpen", {
  pattern = { "*" },
  callback = function()
    if vim.g.terminalbuf ~= nil and vim.api.nvim_buf_is_valid(vim.g.terminalbuf) then
      vim.api.nvim_buf_delete(vim.g.terminalbuf, { force = true })
    end
    vim.g.terminalbuf = vim.api.nvim_win_get_buf(0)

    vim.cmd "set winfixheight"
    vim.cmd "set winfixheight"
    vim.cmd "wincmd J"
    vim.cmd "resize 20"
    vim.keymap.set("n", "q", "<cmd>q!<cr>", { noremap = true, silent = true, buffer = true })
  end
})

vim.api.nvim_create_autocmd("BufDelete", {
  pattern = { "term://*" },
  callback = function()
    if vim.g.terminalbuf ~= nil then
      vim.keymap.del("n", "q", { buffer = vim.g.terminalbuf })
    end
  end
})

local disable = vim.api.nvim_create_augroup("no_more_D", {})
vim.api.nvim_create_autocmd("InsertEnter", {
  group = disable,
  callback = function()
    vim.diagnostic.enable(false)
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = disable,
  callback = function()
    vim.diagnostic.enable()
  end
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    if client:supports_method('textDocument/completion') then
      local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
      client.server_capabilities.completionProvider.triggerCharacters = chars
      vim.lsp.completion.enable(true, client.id, args.buf)
    end
  end,
})
