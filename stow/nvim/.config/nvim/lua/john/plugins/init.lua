return {
  {
    'windwp/nvim-autopairs',
    opts = {
      map_bs = false,
      map_c_h = false, -- map <C-h> key to delete a pair
      map_c_w = false, -- map <C-w> to delete a pair
    },
  },
  {
    'numToStr/Comment.nvim',
    config = function()
      require 'Comment'.setup()
      vim.keymap.del("n", "gbc")
    end
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({ keymaps = { normal = "s" } })
    end
  },
  {
    'folke/todo-comments.nvim',
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local todo = require 'todo-comments'

      todo.setup({
        keywords = {
          FIX = {
            icon = " ", -- icon used for the sign, and in search results
            color = "error", -- can be a hex color, or a named color (see below)
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
            -- signs = false, -- configure signs for some keywords individually
          },
          TODO = { icon = " ", color = "info" },
          HACK = { icon = " ", color = "warning" },
          WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
          PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
          TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
          fix = {
            icon = " ", -- icon used for the sign, and in search results
            color = "error", -- can be a hex color, or a named color (see below)
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
            -- signs = false, -- configure signs for some keywords individually
          },
          todo = { icon = " ", color = "info" },
          hack = { icon = " ", color = "warning" },
          warn = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
          perf = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          note = { icon = " ", color = "hint", alt = { "INFO" } },
          test = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        }
      })
      require 'todo-comments'.setup({
        keywords = {
          FIX = {
            icon = " ", -- icon used for the sign, and in search results
            color = "error", -- can be a hex color, or a named color (see below)
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
            -- signs = false, -- configure signs for some keywords individually
          },
          TODO = { icon = " ", color = "info" },
          HACK = { icon = " ", color = "warning" },
          WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
          PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
          TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
          fix = {
            icon = " ", -- icon used for the sign, and in search results
            color = "error", -- can be a hex color, or a named color (see below)
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
            -- signs = false, -- configure signs for some keywords individually
          },
          todo = { icon = " ", color = "info" },
          hack = { icon = " ", color = "warning" },
          warn = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
          perf = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          note = { icon = " ", color = "hint", alt = { "INFO" } },
          test = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        }
      })
      vim.keymap.set("n", "<leader>tdf", "<cmd>TodoTelescope<cr>")
      vim.keymap.set("n", "<leader>tdl", "<cmd>TodoLocList<cr>")
    end
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    opts = {},
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
    init = function() vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle) end
  },
  {
    "chrisgrieser/nvim-spider",
    opts = {
      skipInsignificantPunctuation = false,
    },
    keys = {
      { "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" } },
      { "e", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" } },
      { "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" } },
    },
  },
}
