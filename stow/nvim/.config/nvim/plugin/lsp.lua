vim.pack.add({'https://github.com/neovim/nvim-lspconfig'})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    if client:supports_method('textDocument/completion') then
      local chars = {}
      for i = 32, 126 do
        table.insert(chars, string.char(i))
      end
      client.server_capabilities.completionProvider.triggerCharacters = chars
      vim.lsp.completion.enable(true, client.id, args.buf)
    end
  end,
})

vim.opt.complete:append("w")
vim.opt.completeopt = { "menuone", "noinsert", "fuzzy", "noselect" }

vim.keymap.set("n", "<leader>e", function() vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR }) end)
vim.keymap.set("n", "<leader>E", function() vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR }) end)
vim.keymap.set("n", "<leader>d", function() vim.diagnostic.jump({ count = 1 }) end)
vim.keymap.set("n", "<leader>D", function() vim.diagnostic.jump({ count = -1 }) end)
vim.keymap.set("n", "<leader>ad", function() vim.diagnostic.setloclist() end)

vim.lsp.config('omnisharp', { settings = { cmd = { "omnisharp" } } })
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      }
    }
  }
})
