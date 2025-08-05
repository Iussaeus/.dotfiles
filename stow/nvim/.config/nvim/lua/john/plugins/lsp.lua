return {
<<<<<<< HEAD
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
=======
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {},
	},
	{
<<<<<<< HEAD
=======
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

			-- cmp.setup.cmdline(':', {
			-- 	mapping = cmp.mapping.preset.cmdline(),
			-- 	sources = cmp.config.sources({
			-- 		{ name = 'path' }
			-- 	}, {
			-- 		{
			-- 			name = 'cmdline',
			-- 			option = {
			-- 				ignore_cmds = {},
			-- 			}
			-- 		}
			-- 	}),
			-- })

			cmp.setup.cmdline("@", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = 'cmdline-prompt' },
					{ name = 'path' },
				})
			})

			cmp.setup({
				sources = {
					{ name = 'nvim_lsp' },
					{ name = 'buffer' },
					{ name = 'ctags' },
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
				performance = { max_view_entries = 25 },
			})
		end
	},
	-- LSP
	{
>>>>>>> 8cd7fd6 (Small changes, to tmux-sessionizer and nvim config)
		'neovim/nvim-lspconfig',
		config = function()
			local lsp = require 'lspconfig'
<<<<<<< HEAD
			local on_attach = function(client, bufnr)
				vim.lsp.completion.enable(true, client.id, bufnr, {
					convert = function(item)
						return { abbr = item.label:gsub("%b()", "") }
=======

			-- This is where all the LSP shenanigans will live
			local lsp_zero = require('lsp-zero')
			lsp_zero.extend_lspconfig()

			lsp_zero.on_attach(function(_, bufnr)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition)
				vim.keymap.set("n", "K", vim.lsp.buf.hover)
				vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol)
				vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float)
				vim.keymap.set("n", "<leader>ne", function() vim.diagnostic.jump({ count = 1, float = true }) end)
				vim.keymap.set("n", "<leader>e", function() vim.diagnostic.jump({ severity = "ERROR", count = 1, float = true }) end)
				vim.keymap.set("n", "<leader>pe", function() vim.diagnostic.jump({ count = -1, float = true }) end)
				vim.keymap.set("n", "<leader>ad", vim.diagnostic.setloclist)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
				vim.keymap.set("n", "<leader>vr", vim.lsp.buf.references)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
				vim.keymap.set("i", "<A-h>", vim.lsp.buf.signature_help)
				vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
				vim.keymap.set("n", "<leader>i",
					function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }), { 0 }) end)
			end)

			local skill = vim.api.nvim_create_augroup("my_group", {});

			require('mason').setup({})
			require('mason-lspconfig').setup({
				ensure_installed = { 'pylsp', 'omnisharp', 'lua_ls', "gopls" },
				handlers = {
					lsp_zero.default_setup,
					lua_ls = function()
						local lua_opts = lsp_zero.nvim_lua_ls()
						require('lspconfig').lua_ls.setup(lua_opts)
>>>>>>> 8cd7fd6 (Small changes, to tmux-sessionizer and nvim config)
					end,
				})
			end

			vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float)
			vim.keymap.set("n", "<leader>ne", function() vim.diagnostic.jump({ count = 1 }) end)
			vim.keymap.set("n", "<leader>ad", function() vim.diagnostic.setloclist() end)
			vim.keymap.set("n", "<leader>e",  function() vim.diagnostic.jump({ count = -1 }) end)
			vim.keymap.set("n", "<leader>pe", function() vim.diagnostic.jump({ count = -1, severity = "ERROR" }) end)
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
			vim.keymap.set("n", "<leader>vr", vim.lsp.buf.references)
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
			vim.keymap.set("n", "<leader>f",  vim.lsp.buf.format)
			vim.keymap.set("n", "gd",         vim.lsp.buf.definition)
			vim.keymap.set("n", "K",          vim.lsp.buf.hover)

			vim.keymap.set("i", "<C-space>", vim.lsp.completion.get)
			vim.opt.completeopt = { "menuone", "noselect", "popup", "fuzzy" }
			lsp.lua_ls.setup { on_attach = on_attach }
			lsp.gopls.setup { on_attach = on_attach }

			local disable = vim.api.nvim_create_augroup("disable_diagnostic", {})
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
		end,
	},
>>>>>>> 3c7a26e (changed the nvim config)
}
