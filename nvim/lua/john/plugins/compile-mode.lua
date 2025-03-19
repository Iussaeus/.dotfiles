return {
	"ej-shafran/compile-mode.nvim",
	vesion = "5.*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "m00qek/baleia.nvim", tag = "v1.3.0" },
	},
	config = function()
		vim.g.compile_mode = {
			baleia_setup = true,
			default_command = "",
			use_diagnostics = true,
		}

		local prev_cwd = ""
		vim.api.nvim_create_autocmd("BufLeave", {
			pattern = "compilation",
			group = vim.api.nvim_create_augroup("compile-group", {}),
			callback = function()
				vim.cmd("cd " .. prev_cwd)
			end
		})

		local compile_in_file_cwd = function()
			prev_cwd = vim.fn.getcwd()
			local buf = vim.api.nvim_get_current_buf()
			local current_file = vim.api.nvim_buf_get_name(buf)
			local file_cwd = vim.fn.fnamemodify(current_file, ':h')

			vim.cmd("cd " .. file_cwd:gsub("oil://", ""))
			vim.cmd [[botright 15 Compile]]
		end

		vim.keymap.set("n", "<leader>cm", compile_in_file_cwd)
		vim.keymap.set("n", "<leader>cr", "<cmd>:botright 15 :Recompile<cr>")
		vim.keymap.set("n", "<leader>cn", require 'compile-mode'.next_error)
		vim.keymap.set("n", "<leader>cp", require 'compile-mode'.prev_error)
	end
}
