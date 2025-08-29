require('john.map')
require('john.set')

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "help", "man" },
	callback = function()
		vim.cmd "wincmd L"
		vim.cmd "wincmd 25<"
	end
})

vim.api.nvim_create_autocmd("TermOpen", {
	pattern = { "*" },
	callback = function()
		if vim.fn.expand("%:p"):match(".*tgpt") then
			vim.cmd "wincmd L"
			vim.cmd "wincmd 35<"
		else
			vim.cmd "wincmd J"
			vim.cmd "wincmd 10-"
		end
	end
})

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "copilot-chat" },
	callback = function()
		vim.cmd "wincmd L"
		vim.cmd "wincmd 35<"
	end
})


require("lazy").setup('john.plugins')
