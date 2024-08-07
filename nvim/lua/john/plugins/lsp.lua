return {
	{'williamboman/mason.nvim'},
	{'williamboman/mason-lspconfig.nvim',
	config = function()
		local lsp_zero = require'lsp-zero'
		require('mason').setup({})
		require('mason-lspconfig').setup({
			ensure_installed = { 'pylsp', 'omnisharp', 'lua_ls'},
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
		vim.g.lsp_zero_extend_cmp = 0
		vim.g.lsp_zero_extend_lspconfig = 0
	end,
},

-- Autocompletion
{
	'hrsh7th/nvim-cmp',
	event = 'InsertEnter',
	dependencies = {
		{'L3MON4D3/LuaSnip'},
	},
	config = function()
		-- Here is where you configure the autocompletion settings.
		local lsp_zero = require('lsp-zero')
		lsp_zero.extend_cmp()

		-- And you can configure cmp even more, if you want to.
		local cmp = require('cmp')
		local cmp_action = lsp_zero.cmp_action()

		cmp.setup({
			sources = {
				{name = 'nvim_lua'},
				{name = 'nvim_lsp'},
				{name = 'path'},
			},

			formatting = lsp_zero.cmp_format({details = true}),
			mapping = cmp.mapping.preset.insert({
				['<C-Space>'] = cmp.mapping.complete(),
				['<C-u>'] = cmp.mapping.scroll_docs(-4),
				['<C-d>'] = cmp.mapping.scroll_docs(4),
				['<C-f>'] = cmp_action.luasnip_jump_forward(),
				['<C-b>'] = cmp_action.luasnip_jump_backward(),
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
	event = {'BufReadPre', 'BufNewFile'},
	dependencies = {
		{'hrsh7th/cmp-nvim-lsp'},
	},
	config = function()
		local lsp = require'lspconfig'
		local capabilities = require'cmp_nvim_lsp'.default_capabilities()
		-- This is where all the LSP shenanigans will live
		local lsp_zero = require('lsp-zero')
		lsp_zero.extend_lspconfig()

		lsp_zero.on_attach(function(client, bufnr)

			local opts = {buffer = bufnr, remap = false}

			vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
			vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
			vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
			vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
			vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
			vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
			vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
			vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
			vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
			vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
			vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
			vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end, opts)
		end)

			require('mason').setup({})
			require('mason-lspconfig').setup({
				handlers = {
					lsp_zero.default_setup,
				}
			})
		-- (Optional) Configure lua language server for neovim
		local lua_opts = lsp_zero.nvim_lua_ls()
		require('lspconfig').lua_ls.setup(lua_opts)

		-- Gdscript configuration
		local port = os.getenv('GDScript_Port') or '6005'
		local cmd = {'ncat', '127.0.0.1', port}
		local pipe = [[\\.\pipe\godot.pipe]]
		local lsp_flags = {
			-- This is the default in Nvim 0.7+
			debounce_text_changes = 150,
		}
		-- Note: There's no need to download the lsp since it's started with the editor
		lsp.gdscript.setup{
			flags = lsp_flags,
			cmd = cmd,
			filetypes = { "gd", "gdscript", "gdscript3" },
			on_attach = function(client, bufnr)
				vim.api.nvim_command([[echo serverstart(']] .. pipe .. [[')]])
			end
		}
			-- Kotlin deez nuts
		lsp.kotlin_language_server.setup{
			filetypes = {"kt"},
			cmd = {'kotlin-language-server'},
			init_options = {
				AutomaticWorkspaceInit = true
			}
		}
		-- C# configuration
		lsp.csharp_ls.setup{
			filetypes = {"cs"},
			cmd = {'omnisharp'},
			root_dir = lsp.util.root_pattern('*.sln', '*.csproj', '*.fsproj', '.git'),
			init_options = {
				AutomaticWorkspaceInit = true
			}
		}
		-- Ocaml configuration
		lsp.ocamllsp.setup({
			cmd = { "ocamllsp" },
			filetypes = { "ocaml", "ocaml.menhir", "ocaml.interface", "ocaml.ocamllex", "reason", "dune" },
			root_dir = lsp.util.root_pattern("*.opam", "esy.json", "package.json", ".git", "dune-project", "dune-workspace"),
			capabilities = capabilities
		})
		-- Diagnostics
		vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
		vim.lsp.diagnostic.on_publish_diagnostics,
		{
			virtual_text = true,
			signs = true,
			update_in_insert = true,
			underline = true,
		})
	end
}
}
