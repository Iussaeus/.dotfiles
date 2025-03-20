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
			use_diagnostics = true,
			default_command = "",
		}

		local split_opts = "botright 15"

		local prev_wd = ""
		local prev_fwd = ""
		local prev_cmd = ""

		local compile_in_fwd = function()
			local file_cwd = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':h')
			local prefix = file_cwd:match("^(.*://)")

			if prefix == "fugitive://" then
				print("Don't execute in fugitive.")
				return
			end

			if prefix == "oil://" then
				file_cwd = file_cwd:gsub(prefix, "")
			end

			local input = vim.fn.input({ prompt = "Compile: ", completion = "shellcmd" })

			if input == "" then return end

			prev_wd = vim.fn.getcwd()
			prev_fwd = file_cwd
			prev_cmd = input

			vim.cmd('cd ' .. file_cwd)
			vim.cmd(split_opts .. ' Compile ' .. input)
			vim.cmd('cd ' .. prev_wd)
		end

		local recompile_in_prev_fwd = function()
			if prev_fwd == "" or prev_wd == "" or prev_cmd == "" then
				print("Nothing to Recompile.")
				return
			end

			vim.cmd('cd ' .. prev_fwd)
			vim.cmd(split_opts .. ' Recompile ')
			vim.cmd('cd ' .. prev_wd)
		end

		vim.keymap.set("n", "<leader>cm", compile_in_fwd)
		vim.keymap.set("n", "<leader>cr", recompile_in_prev_fwd)
		vim.keymap.set("n", "<leader>cn", require 'compile-mode'.next_error)
		vim.keymap.set("n", "<leader>cp", require 'compile-mode'.prev_error)
	end
}
