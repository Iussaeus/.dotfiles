return {
  { 'williamboman/mason.nvim', },
  { 'williamboman/mason-lspconfig.nvim', },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {},
  },
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = false,
  },
  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'BufEnter',
    dependencies = {
      { 'L3MON4D3/LuaSnip',
        'hrsh7th/cmp-cmdline',
        'teramako/cmp-cmdline-prompt.nvim',
        'hrsh7th/cmp-buffer',
        'delphinus/cmp-ctags',
        'folke/lazydev.nvim',
        'hrsh7th/cmp-path',
      },
    },
    config = function()
      local lsp_zero = require('lsp-zero')
      local cmp = require('cmp')
      local cmp_action = lsp_zero.cmp_action()

      lsp_zero.extend_cmp()

      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      cmp.setup.cmdline("@", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          -- { name = 'cmdline-prompt' },
          { name = 'path' },
        })
      })

      cmp.setup({
        sources = {
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'lazydev', group_index = 0 },
        },

        formatting = lsp_zero.cmp_format({ details = true }),
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-y>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }),
          ['<C-n>'] = cmp_action.tab_complete(),
          ['<C-p>'] = cmp_action.select_prev_or_fallback(),
        }),
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },

      })
    end
  },
  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = 'LspInfo',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
    },
    config = function()
      local lsp = require 'lspconfig'

      -- This is where all the LSP shenanigans will live
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_lspconfig()

      lsp_zero.on_attach(function(_, bufnr)
        vim.keymap.del("n", "gb")
        vim.keymap.set("n", "gd", function()
          vim.cmd "mark B"; vim.lsp.buf.definition()
        end)
        vim.keymap.set("n", "gb", "'Bzz")
        vim.keymap.set("n", "K", vim.lsp.buf.hover)
        vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol)
        vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float)
        vim.keymap.set("n", "<leader>nd", function() vim.diagnostic.jump({ count = 1, float = true }) end)
        vim.keymap.set("n", "<leader>e",
          function() vim.diagnostic.jump({ severity = "ERROR", count = 1, float = true }) end)
        vim.keymap.set("n", "<leader>pd", function() vim.diagnostic.jump({ count = -1, float = true }) end)
        vim.keymap.set("n", "<leader>ad", vim.diagnostic.setloclist)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
        vim.keymap.set("n", "<leader>vr", vim.lsp.buf.references)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
        vim.keymap.set("i", "<A-h>", vim.lsp.buf.signature_help)
        vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
        vim.keymap.set("n", "<leader>i",
          function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }), { 0 }) end)
      end)
      require('mason').setup({})
      require('mason-lspconfig').setup({
        ensure_installed = { 'lua_ls', "gopls", "ocamllsp" },
        handlers = {
          lsp_zero.default_setup,
          lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
          end,
        }
      })
    end
  },
}
