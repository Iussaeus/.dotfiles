return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "leoluz/nvim-dap-go",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require "dap"
      local ui = require "dapui"

      require("dapui").setup()
      require("dap-go").setup()
      require("nvim-dap-virtual-text").setup {}

      vim.fn.sign_define('DapBreakpoint', { text = '' })

      vim.keymap.set("n", "<space>?", function()
        require("dapui").eval(nil, { enter = true })
      end)

      vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
      vim.keymap.set("n", "<leader>drc", dap.run_to_cursor)

      vim.keymap.set("n", "<leader>dc", dap.continue)
      vim.keymap.set("n", "<leader>dsi", dap.step_into)
      vim.keymap.set("n", "<leader>dsov", dap.step_over)
      vim.keymap.set("n", "<leader>dso", dap.step_out)
      vim.keymap.set("n", "<leader>dsb", dap.step_back)
      vim.keymap.set("n", "<leader>dr", dap.restart)
      vim.keymap.set("n", "<leader>dd", dap.disconnect)

      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end
    end,
  },
}
