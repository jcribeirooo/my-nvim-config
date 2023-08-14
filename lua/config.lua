vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = true
vim.opt.cursorline = true
vim.wo.number = true
vim.opt.termguicolors = true

vim.cmd([[ let &colorcolumn = join(range(81,999), ',') ]])