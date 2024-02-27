-- Lsp 
-- Lsp locals
local lsp_zero = require('lsp-zero')
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local lsp = require'lspconfig'
local capabilities = require'cmp_nvim_lsp'.default_capabilities
-- General lsp mappings
lsp_zero.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)
-- Tab complete
cmp.setup({
	sources = {
		{name = 'nvim_lua'},
		{name = 'nvim_lsp'},
		{name = 'path'},
	},
	formatting = lsp_zero.cmp_format(),
	mapping = cmp.mapping.preset.insert({
		['<Tab>'] = cmp.mapping.confirm({ select = true }),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-j>'] = cmp_action.tab_complete(),
		['<C-k>'] = cmp_action.select_prev_or_fallback(),
	}),
})
-- Mason config to downloand selected lsp
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
-- Gdscript configuration
local port = os.getenv('GDScript_Port') or '6005'
local cmd = {'ncat', '127.0.0.1', port}
local pipe = [[\\.\pipe\godot.pipe]]
local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}
-- Note: There's no need to download the lsp since it's started with the editor
require'lspconfig'.gdscript.setup{
  flags = lsp_flags,
  cmd = cmd,
  filetypes = { "gd", "gdscript", "gdscript3" },
  on_attach = function(client, bufnr)
    vim.api.nvim_command([[echo serverstart(']] .. pipe .. [[')]])
  end
}
-- C# configuration
require'lspconfig'.csharp_ls.setup{
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
})
-- MATLAB configuration
require('mason-lspconfig').setup({
    ensure_installed = {
        'matlab_ls'
    },
    handlers = {
        matlab_ls = function()
            require('lspconfig').matlab_ls.setup({
                filetypes = {"matlab"},
                settings = {
                    matlab = {
                        installPath = "/opt/matlab/R2023a/"
                    },
                },
                single_file_support = true
            })
        end,
    },
})
-- Diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics,
{
	virtual_text = true,
	signs = true,
	update_in_insert = true,
	underline = true,
}
)
