vim.o.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"

vim.o.number = true
vim.o.relativenumber = true
vim.o.smartindent = true
vim.o.showmode = false

vim.o.smartcase = true
vim.o.ignorecase = true

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.wrap = false
vim.o.showbreak = "->"
vim.o.foldenable = false
vim.o.foldmethod = 'manual'

vim.o.swapfile = false
vim.o.backup = false
vim.o.undofile = true

vim.o.hlsearch = false
vim.o.incsearch = true

vim.o.termguicolors = true

vim.o.sidescrolloff = 25
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.o.autocomplete = true
vim.o.pumheight = 10
vim.o.pumborder = 'rounded'
vim.opt.complete:append("b")
vim.opt.complete:append("w")
vim.opt.complete:append("i")
vim.opt.complete:append("t")
vim.opt.complete:append("o")
vim.opt.complete:append("")
vim.opt.complete:append("i")
vim.opt.completeopt = { "menuone", "fuzzy", "noselect" }

vim.o.updatetime = 100
vim.o.autoread = true

vim.o.colorcolumn = "100"
