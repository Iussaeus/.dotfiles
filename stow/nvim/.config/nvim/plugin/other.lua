-- random dependencies
vim.pack.add { 'https://github.com/nvim-treesitter/nvim-treesitter' }
vim.pack.add { 'https://github.com/kylechui/nvim-surround' }
vim.pack.add({ "https://github.com/tpope/vim-fugitive" })

-- undo
vim.cmd.packadd 'nvim.undotree'
vim.keymap.set({ 'n', 'x' }, '<m-u>', vim.cmd.Undotree)

-- align
vim.pack.add({ 'https://github.com/nvim-mini/mini.align' })
require 'mini.align'.setup { mappings = { start = nil, start_with_preview = 'ga', }, }

-- git-signs
vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })
require "gitsigns".setup()
vim.keymap.set("n", "<leader>hr", "<cmd>Gitsigns reset_hunk<cr>")
vim.keymap.set("v", "<leader>hr", ":'<,'>Gitsigns reset_hunk<cr>")

-- opencode
vim.pack.add({
  {
    src = "https://github.com/nickjvandyke/opencode.nvim",
    -- Defaults to "main", supporting OpenCode v2.
    -- Uncomment to pull the latest stable release, supporting OpenCode v1.
    -- version = vim.version.range("*"),
  },
})

---@type opencode.Opts
vim.g.opencode_opts = {
  -- Your configuration, if any; goto definition on the type for details
}

-- Recommended/example keymaps
vim.keymap.set({ "n", "x" }, "<leader>oa", function() require("opencode").ask("@this: ") end)
vim.keymap.set({ "n", "x" }, "<leader>os", function() require("opencode").select() end)
