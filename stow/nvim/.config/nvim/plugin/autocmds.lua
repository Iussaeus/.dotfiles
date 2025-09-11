vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help", "man" },
  callback = function()
    vim.cmd "wincmd L"
    vim.cmd "wincmd 25<"
  end
})

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = { "*" },
  callback = function()
    if vim.fn.expand("%:p"):match(".*tgpt") then
      vim.cmd "wincmd L"
      vim.cmd "wincmd 35<"
    else
      vim.cmd "wincmd J"
      vim.cmd "wincmd 10-"
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
