return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      vim.opt.complete:append("w")
      vim.opt.completeopt = { "menuone", "noinsert", "fuzzy", "noselect" }

      vim.keymap.set("n", "<leader>e", function() vim.diagnostic.jump({ count = 1, severity = "ERROR" }) end)
      vim.keymap.set("n", "<leader>E", function() vim.diagnostic.jump({ count = -1, severity = "ERROR" }) end)
      vim.keymap.set("n", "<leader>d", function() vim.diagnostic.jump({ count = 1 }) end)
      vim.keymap.set("n", "<leader>D", function() vim.diagnostic.jump({ count = -1 }) end)
      vim.keymap.set("n", "<leader>ad", function() vim.diagnostic.setloclist() end)

      vim.lsp.enable('gopls')
      vim.lsp.enable('ols')

      vim.lsp.config('omnisharp', { settings = { cmd = { "omnisharp" } } })
      vim.lsp.enable('omnisharp')

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
      vim.lsp.enable('lua_ls')
    end,
  },
}
