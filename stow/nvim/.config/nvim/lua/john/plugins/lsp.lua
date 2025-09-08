return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {},
  },
	{
		'neovim/nvim-lspconfig',
		config = function()
			local lsp = require 'lspconfig'
			local on_attach = function(client, bufnr)
				vim.lsp.completion.enable(true, client.id, bufnr, {
					convert = function(item)
						return { abbr = item.label:gsub("%b()", "") }
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
}
