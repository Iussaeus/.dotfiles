return {
	{ 'williamboman/mason.nvim' },
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
			vim.g.lsp_zero_extend_cmp = 0
			vim.g.lsp_zero_extend_lspconfig = 0
		end,
	},

	-- Autocompletion
	{
		'hrsh7th/nvim-cmp',
		event = 'InsertEnter',
		dependencies = {
			{ 'L3MON4D3/LuaSnip' },
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
					{ name = 'nvim_lua' },
					{ name = 'nvim_lsp' },
					{ name = 'path' },
				},

				formatting = lsp_zero.cmp_format({ details = true }),
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
				vim.keymap.set("n", "<leader>e", function() vim.diagnostic.goto_next() end, opts)
				vim.keymap.set("n", "<leader>pe", function() vim.diagnostic.goto_prev() end, opts)
				vim.keymap.set("n", "<A-CR>", function() vim.lsp.buf.code_action() end, opts)
				vim.keymap.set("n", "<leader>vr", function() vim.lsp.buf.references() end, opts)
				vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
				vim.keymap.set("i", "<A-h>", function() vim.lsp.buf.signature_help() end, opts)
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

			-- Note: There's no need to download the lsp since it's started with the editor
			lsp.gdscript.setup {
				filetypes = { "gd", "gdscript", "gdscript3" },
			}

			local shader_group = vim.api.nvim_create_augroup("shader", { clear = true })

			vim.api.nvim_create_autocmd("BufEnter",
				{
					command = ":lua Gdshader()",
					group = shader_group,
					pattern = { "*.gdshader" },
				})

			function Gdshader()
				vim.lsp.start {
					name = "gdshader",
					cmd = { "gdshader-lsp" },
					capabilities = capabilities,
				}
			end

			-- Kotlin deez nuts
			lsp.kotlin_language_server.setup {
				filetypes = { "kt" },
				cmd = { 'kotlin-language-server' },
				init_options = {
					AutomaticWorkspaceInit = true
				}
			}

			lsp.gopls.setup {
				filetypes = { "go" },
				capabilities = capabilities,
			}

			-- C# configuration
			lsp.omnisharp.setup {
				filetypes = { "cs" },
				cmd = { 'omnisharp' },
				init = function()
					require("lazyvim.util").on_attach(function(client, _)
						if client.name == "omnisharp" then
							client.server_capabilities.semanticTokensProvider = {
								full = vim.empty_dict(),
								legend = {
									tokenModifiers = { "static_symbol" },
									tokenTypes = {
										"comment",
										"excluded_code",
										"identifier",
										"keyword",
										"keyword_control",
										"number",
										"operator",
										"operator_overloaded",
										"preprocessor_keyword",
										"string",
										"whitespace",
										"text",
										"static_symbol",
										"preprocessor_text",
										"punctuation",
										"string_verbatim",
										"string_escape_character",
										"class_name",
										"delegate_name",
										"enum_name",
										"interface_name",
										"module_name",
										"struct_name",
										"type_parameter_name",
										"field_name",
										"enum_member_name",
										"constant_name",
										"local_name",
										"parameter_name",
										"method_name",
										"extension_method_name",
										"property_name",
										"event_name",
										"namespace_name",
										"label_name",
										"xml_doc_comment_attribute_name",
										"xml_doc_comment_attribute_quotes",
										"xml_doc_comment_attribute_value",
										"xml_doc_comment_cdata_section",
										"xml_doc_comment_comment",
										"xml_doc_comment_delimiter",
										"xml_doc_comment_entity_reference",
										"xml_doc_comment_name",
										"xml_doc_comment_processing_instruction",
										"xml_doc_comment_text",
										"xml_literal_attribute_name",
										"xml_literal_attribute_quotes",
										"xml_literal_attribute_value",
										"xml_literal_cdata_section",
										"xml_literal_comment",
										"xml_literal_delimiter",
										"xml_literal_embedded_expression",
										"xml_literal_entity_reference",
										"xml_literal_name",
										"xml_literal_processing_instruction",
										"xml_literal_text",
										"regex_comment",
										"regex_character_class",
										"regex_anchor",
										"regex_quantifier",
										"regex_grouping",
										"regex_alternation",
										"regex_text",
										"regex_self_escaped_character",
										"regex_other_escape",
									},
								},
								range = true,
							}
						end
					end)
				end,
				root_dir = lsp.util.root_pattern('*.sln', '*.csproj', '*.fsproj', '.git'),
			}

			-- Arduino LSP
			lsp.arduino_language_server.setup({
				cmd = {
					"arduino-language-server",
					"-clangd", "/usr/bin/clangd",
					"-cli", "/usr/bin/arduino-cli",
					"-cli-config", "/home/john/.arduino15/arduino-cli.yaml",
				},
				capabilities = capabilities,
			})
			-- Ocaml configuration
			lsp.ocamllsp.setup({
				cmd = { "ocamllsp" },
				filetypes = { "ocaml", "ocaml.menhir", "ocaml.interface", "ocaml.ocamllex", "reason", "dune" },
				root_dir = lsp.util.root_pattern("*.opam", "esy.json", "package.json", ".git", "dune-project",
					"dune-workspace"),
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
