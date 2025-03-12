return {
	{ 'williamboman/mason.nvim', },
	{
		'williamboman/mason-lspconfig.nvim',
		config = function()
			local lsp_zero = require 'lsp-zero'
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
		end
	},

	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		lazy = true,
		config = false,
		init = function()
			-- Disable automatic setup, we are doing it manually
			vim.g.lsp_zero_extend_cmp = 1
			vim.g.lsp_zero_extend_lspconfig = 1
		end,
	},

	-- Autocompletion
	{
		'hrsh7th/nvim-cmp',
		event = 'InsertEnter',
		dependencies = {
			{ 'L3MON4D3/LuaSnip',
				'teramako/cmp-cmdline-prompt.nvim',
				'hrsh7th/cmp-buffer',
				'delphinus/cmp-ctags',
			},
		},
		config = function()
			-- Here is where you configure the autocompletion settings.

			local lsp_zero = require('lsp-zero')
			lsp_zero.preset("recommended")
			lsp_zero.extend_cmp()

			require('mason').setup({})
			require('mason-lspconfig').setup({
				handlers = {
					lsp_zero.default_setup,
				}

			})

			-- And you can configure cmp even more, if you want to.
			local cmp = require('cmp')
			local cmp_action = lsp_zero.cmp_action()

			cmp.setup.cmdline("@", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = 'cmdline-prompt' },
				})
			})
			cmp.setup({
				sources = {
					{ name = 'nvim_lsp' },
					{ name = 'buffer' },
					{ name = 'ctags' },
				},

				formatting = lsp_zero.cmp_format({ details = true }),
				mapping = cmp.mapping.preset.insert({
					['<C-Space>'] = cmp.mapping.complete(),
					['<Tab>'] = cmp.mapping.confirm({ select = true }),
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
			local capabilities = require 'cmp_nvim_lsp'.default_capabilities()

			-- This is where all the LSP shenanigans will live
			local lsp_zero = require('lsp-zero')
			lsp_zero.extend_lspconfig()

			lsp_zero.on_attach(function(client, bufnr)
				local opts = { buffer = bufnr, remap = false }

				vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
				vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
				vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
				vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
				vim.keymap.set("n", "<leader>ne", function() vim.diagnostic.goto_next() end, opts)
				vim.keymap.set("n", "<leader>ad", function() vim.diagnostic.setloclist() end)
				vim.keymap.set("n", "<leader>e", function() vim.diagnostic.goto_next() end, opts)
				vim.keymap.set("n", "<leader>pe", function() vim.diagnostic.goto_prev() end, opts)
				vim.keymap.set("n", "<A-CR>", function() vim.lsp.buf.code_action() end, opts)
				vim.keymap.set("n", "<leader>vr", function() vim.lsp.buf.references() end, opts)
				vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
				vim.keymap.set("i", "<A-h>", function() vim.lsp.buf.signature_help() end, opts)
				vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end, opts)
				vim.keymap.set("n", "<leader>i",
					function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }), { 0 }) end, opts)

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
			end)

			-- (Optional) Configure lua language server for neovim
			local lua_opts = lsp_zero.nvim_lua_ls()
			require('lspconfig').lua_ls.setup(lua_opts)

			lsp.gdscript.setup {
				filetypes = { "gd", "gdscript", "gdscript3" },
			}

			require 'lspconfig'.clangd.setup {
				filetypes = { "c", "cpp", "cc", "mpp", "ixx" },
				cmd = {
					"clangd",
					"--background-index",
					"-j=10",
					"--experimental-modules-support",
					"--clang-tidy",
					"--all-scopes-completion",
					"--completion-style=bundled",
					"--enable-config"
					-- "--header-insertion-decorators",
					-- "--header-insertion=iwyu",
					-- "--pch-storage=memory",
				}
			}

			-- C# configuration
			lsp.omnisharp.setup {
				filetypes = { "cs" },
				cmd = { 'omnisharp' },
				root_dir = lsp.util.root_pattern('*.sln', '*.csproj', '*.fsproj', '.git'),
			}
		end,
	},
}
