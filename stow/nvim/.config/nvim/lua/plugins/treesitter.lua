---@diagnostic disable
return {
  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      local ok, ts = pcall(require, "nvim-treesitter.configs")
      if not ok then return end

      ts.setup {
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
        auto_install = false,
        highlight = { enable = true },
      }
    end,
  }
}
