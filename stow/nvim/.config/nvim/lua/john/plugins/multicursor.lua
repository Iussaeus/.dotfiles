return {
    {
        'mg979/vim-visual-multi',
        branch = 'master',
        lazy = false,
        init = function()
            vim.g.VM_set_statusline = 0
            vim.g.VM_skip_empty_lines = 1
            vim.g.VM_silent_exit = 1
            vim.g.VM_default_mappings = 0
            vim.g.VM_maps = {
                ["Run Normal"] = "<leader>n",
                ["Run Visual"] = "<leader>v",
                ["Run Macro"] = "<leader>m",
                ["Find Subword Under"] = "s",
                ["Find Next"] = "<c-n>",
                ["Find Prev"] = "<c-p>",
                ["Select All"] = "<leader>sa",
                ["Add Cursor Down"] = "<C-Down>",
                ["Add Cursor Up"] = "<C-Up>",
                ["Start Regex Search"] = "<leader>/",
                ["Align"] = "<leader>a",
                ["Align Char"] = "<leader>ac",
                ["Align Regex"] = "<leader>ar",
                ["Visual Cursors"] = "<C-n>",
                ["Visual Regex"] = "/",
                ["Surround"] = "S",
                ["Tools Menu"] = "<leader>t",
            }
        end,

        config = function()
            vim.cmd('VMTheme codedark')
        end,
    },
}
