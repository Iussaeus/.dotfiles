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

			cmp.setup.cmdline(':', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = 'path' }
				}, {
					{
						name = 'cmdline',
						option = {
							ignore_cmds = {},
						}
					}
				}),
			})

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
					['<C-y>'] = cmp.mapping.confirm({ select = true }),
					['<C-n>'] = cmp_action.tab_complete(),
					['<C-p>'] = cmp_action.select_prev_or_fallback(),
				}),
				snippet = {
					expand = function(args)
						require('luasnip').lsp_expand(args.body)
					end,
				},
				performance = { max_view_entries = 15, },
			})
		end
	},
	{
		"ray-x/lsp_signature.nvim",
		opts = {
			always_triger = false,
			floating_window = false,
			hint_prefix = " :: ",
		},
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
				vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end)
				vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end)
				vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end)
				vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end)
				vim.keymap.set("n", "<leader>ne", function() vim.diagnostic.goto_next() end)
				vim.keymap.set("n", "<leader>ad", function() vim.diagnostic.setloclist() end)
				vim.keymap.set("n", "<leader>e", function() vim.diagnostic.goto_next() end)
				vim.keymap.set("n", "<leader>pe", function() vim.diagnostic.goto_prev() end)
				vim.keymap.set("n", "<A-CR>", function() vim.lsp.buf.code_action() end)
				vim.keymap.set("n", "<leader>vr", function() vim.lsp.buf.references() end)
				vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end)
				vim.keymap.set("i", "<A-h>", function() vim.lsp.buf.signature_help() end)
				vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end)
				vim.keymap.set("n", "<leader>i",
					function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }), { 0 }) end)
			end)

			local skill = vim.api.nvim_create_augroup("my_group", {});

			vim.api.nvim_create_autocmd("BufWritePost", {
				group = skill,
				callback = function()
					vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
						vim.lsp.diagnostic.on_publish_diagnostics,
						{
							virtual_text = true,
							signs = true,
							update_in_insert = false,
							underline = true,
						})
				end
			})

			vim.api.nvim_create_autocmd("TextChanged", {
				group = skill,
				callback = function()
					vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
						vim.lsp.diagnostic.on_publish_diagnostics,
						{
							virtual_text = false,
							signs = false,
							update_in_insert = false,
							underline = false,
						})
				end,
			})

			vim.api.nvim_create_autocmd("InsertLeave", {
				group = skill,
				callback = function()
					vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
						vim.lsp.diagnostic.on_publish_diagnostics,
						{
							virtual_text = false,
							signs = false,
							update_in_insert = false,
							underline = false,
						})
				end,
			})

			require('mason').setup({})
			require('mason-lspconfig').setup({
				ensure_installed = { 'pylsp', 'omnisharp', 'lua_ls', "gopls" },
				handlers = {
					lsp_zero.default_setup,
					lua_ls = function()
						local lua_opts = lsp_zero.nvim_lua_ls()
						require('lspconfig').lua_ls.setup(lua_opts)
					end,
				}
			})

			lsp.clangd.setup {
				filetypes = { "cpp", "cppm" },
				cmd = {"clangd", "--experimental-modules-support", "--clang-tidy=0"},
			}
			lsp.gdscript.setup { filetypes = { "gd", "gdscript", "gdscript3" }, }
		end,
	},
}
