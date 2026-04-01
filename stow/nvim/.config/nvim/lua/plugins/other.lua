return {
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    init = function()
      vim.keymap.set('n', "s", "<plug>(nvim-surround-normal)")
    end
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ft = { 'markdown', 'quarto' },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          vim.opt_local.formatoptions:append("r")
          vim.opt_local.comments = {
            "b:- [ ]",
            "b:-",
          }
        end,
      })
    end
  },
  {
    "mbbill/undotree",
    init = function()
      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
    end
  },
  {
    "chrisgrieser/nvim-spider",
    keys = {
      { "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" } },
      { "e", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" } },
      { "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" } },
    },
  },
}
