-- Terminal config
require("terminal").setup({
    layout = { open_cmd = "botright new"},
    cmd = { vim.o.shell },
	autoclose = false,
}
)
-- Simple function to run code
local terminal = require'terminal'
local function run_code()
	vim.cmd("w")
	local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p")
	local root_dir = vim.fn.getcwd()
	local proj_name = vim.fn.fnamemodify(root_dir, ":t")
	local extension = vim.fn.fnamemodify(filename, ":e")
	local cases = {
		['cs'] = function ()
			local cmd = 'dotnet run '
			terminal.run(cmd, {layout = { open_cmd = "botright new"}})
		end,
		['py'] = function ()
			local cmd = 'python3 ' .. filename
			terminal.run(cmd , {layout = { open_cmd = "botright new"}})
		end,
		['ml'] = function ()
			local cmd = 'dune exec ' .. proj_name
			terminal.run(cmd, {layout = { open_cmd = "botright new"}})
		end,
		['m' or 'matlab'] = function ()
			filename = vim.fn.fnamemodify(filename, ":t:r")
			local cmd = 'matlab -nosplash -nodesktop  -r ' .. filename .. ' -logfile c:\\temp\\logfile'
			terminal.run(cmd, {layout = { open_cmd = "botright new"}} )
		end,
		['default'] = function ()
			print("Sorry Bro, not implemented...")
		end
	}
	cases[extension] = cases[extension] or cases['default']
	cases[extension](extension)
end

-- Mappings
local term_map = require("terminal.mappings")
vim.keymap.set({ "n", "x" }, "<leader>ts", term_map.operator_send, { expr = true })
vim.keymap.set("n", "<leader>to", function () term_map.toggle()  return '<C-w>10-'end)
vim.keymap.set("n", "<leader>tr", run_code)
vim.keymap.set("n", "<leader>tk", term_map.kill)
vim.keymap.set("n", "<leader>t]", term_map.cycle_next)
vim.keymap.set("n", "<leader>t[", term_map.cycle_prev)
vim.keymap.set("n", "<leader>tl", term_map.move({ open_cmd = "belowright vnew" }))
vim.keymap.set("n", "<leader>tL", term_map.move({ open_cmd = "botright vnew" }))
vim.keymap.set("n", "<leader>th", term_map.move({ open_cmd = "belowright new" }))
vim.keymap.set("n", "<leader>tH", term_map.move({ open_cmd = "botright new" }))
vim.keymap.set("n", "<leader>tf", term_map.move({ open_cmd = "float" }))

-- Auto insert-mode
vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter", "TermOpen" }, {
    callback = function(args)
        if vim.startswith(vim.api.nvim_buf_get_name(args.buf), "term://") then
			vim.cmd('resize 15')
            vim.cmd("startinsert")
        end
    end,
})
