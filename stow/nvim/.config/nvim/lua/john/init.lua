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

require("lazy").setup('john.plugins')
