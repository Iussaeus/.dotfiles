---@diagnostic disable
return {
  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      local status, ts = pcall(require, "nvim-treesitter.configs")
      if (not status) then return end

      ts.setup {
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
        auto_install = false,
        highlight = { enable = true },
      }
    end,
  }
}
