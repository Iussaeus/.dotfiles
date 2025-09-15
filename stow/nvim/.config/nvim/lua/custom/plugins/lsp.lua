return {
  {
    'neovim/nvim-lspconfig',
    init = function()
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
    end,
    config = function()
      local lsp = require 'lspconfig'
      vim.opt.completeopt = { "menuone", "popup", "fuzzy" }

      vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float)
      vim.keymap.set("n", "<leader>ne", function() vim.diagnostic.jump({ count = 1, severity = "ERROR" }) end)
      vim.keymap.set("n", "<leader>ad", function() vim.diagnostic.setloclist() end)
      vim.keymap.set("n", "<leader>e", function() vim.diagnostic.jump({ count = -1 }) end)
      vim.keymap.set("n", "<leader>pe", function() vim.diagnostic.jump({ count = -1, severity = "ERROR" }) end)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
      vim.keymap.set("n", "<leader>vr", vim.lsp.buf.references)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
      vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition)
      vim.keymap.set("n", "K", vim.lsp.buf.hover)
      vim.keymap.set("i", "<C-space>", vim.lsp.completion.get)

      lsp.gopls.setup {}
      lsp.lua_ls.setup {
        settings = { Lua = { workspace = { library = vim.api.nvim_get_runtime_file("", true) } } } }
    end,
  },
}
