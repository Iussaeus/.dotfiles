return {
	'rebelot/terminal.nvim',
	config = function()
		require("terminal").setup({
			layout = { open_cmd = "botright new" },
			cmd = { vim.o.shell },
			autoclose = false,
		}
		)

		-- Simple function to run code
		local terminal = require 'terminal'
		local function run_code()
			vim.cmd("w")
			local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p")
			local root_dir = vim.fn.getcwd()
			local proj_name = vim.fn.fnamemodify(root_dir, ":t")
			local extension = vim.fn.fnamemodify(filename, ":e")
			local cases = {
				['cs'] = function()
					local cmd = 'dotnet run '
					terminal.run(cmd, { layout = { open_cmd = "botright new" } })
				end,
				['py'] = function()
					local cmd = 'python3 ' .. filename
					terminal.run(cmd, { layout = { open_cmd = "botright new" } })
				end,
				['ml'] = function()
					local cmd = 'dune exec ' .. proj_name
					terminal.run(cmd, { layout = { open_cmd = "botright new" } })
				end,
				['default'] = function()
					print("Sorry Bro, not implemented...")
				end
			}
			cases[extension] = cases[extension] or cases['default']
			cases[extension]()
		end


		local term_map = require("terminal.mappings")
		vim.keymap.set("n", "<leader>to", function() term_map.run() end)
		vim.keymap.set("n", "<leader>tc", run_code)
		vim.keymap.set('t', '<esc>', [[<C-\><C-n>]])

		-- vim.api.nvim_create_autocmd("TermOpen", {
		-- 	command = [[setlocal norelativenumber nonumber]]
		-- })
	end,
}
