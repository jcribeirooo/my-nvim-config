vim.g.mapleader = " "
vim.keymap.set("n", "<leader>e", vim.cmd.NvimTreeToggle)
vim.keymap.set("n", "<leader>w", vim.cmd.w)

vim.keymap.set("n", "<S-h>", vim.cmd.bprevious)
vim.keymap.set("n", "<S-l>", vim.cmd.bnext)
vim.keymap.set("n", "<leader>c", vim.cmd.Bdelete)
vim.keymap.set("n", "<leader>q", vim.cmd.q)

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-j>", "<C-w>j")

vim.api.nvim_set_keymap("v", "<Tab>", ">gv", {})
vim.api.nvim_set_keymap("v", "<S-Tab>", "<gv", {})

vim.api.nvim_set_keymap("n", "<A-j>", [[:m .+1<CR>==]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-k>", [[:m .-2<CR>==]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<A-j>", [[<Esc>:m .+1<CR>==gi]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<A-k>", [[<Esc>:m .-2<CR>==gi]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<A-j>", [[:m '>+1<CR>gv=gv]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<A-k>", [[:m '<-2<CR>gv=gv]], { noremap = true, silent = true })

vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})

vim.api.nvim_set_keymap('n', '<F5>', ':Goyo<CR>', { noremap = true, silent = true })
function Goyo_enter()
    vim.cmd('hi CursorLine ctermbg=black term=none cterm=none')
    vim.cmd('set number')
    require("lualine").hide()
end
function Goyo_leave()
    require("lualine").hide({ unhide = true })
end
vim.cmd("autocmd! User GoyoEnter nested lua Goyo_enter()")
vim.cmd("autocmd! User GoyoLeave nested lua Goyo_leave()")
