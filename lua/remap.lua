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

vim.keymap.set("n", "<F9>", vim.cmd.TestNearest)

vim.api.nvim_set_keymap("v", "<Tab>", ">gv", {})
vim.api.nvim_set_keymap("v", "<S-Tab>", "<gv", {})

vim.api.nvim_set_keymap("n", "<A-j>", [[:m .+1<CR>==]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-k>", [[:m .-2<CR>==]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<A-j>", [[<Esc>:m .+1<CR>==gi]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<A-k>", [[<Esc>:m .-2<CR>==gi]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<A-j>", [[:m '>+1<CR>gv=gv]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<A-k>", [[:m '<-2<CR>gv=gv]], { noremap = true, silent = true })

vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})

vim.api.nvim_set_keymap('n', '<F10>', ':Goyo<CR>', { noremap = true, silent = true })

vim.keymap.set("n", "`", function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<leader><F5>', function() require('dap-go').debug_test() end)
vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F6>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F7>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F8>', function() require('dap').step_out() end)

vim.fn.sign_define("DapBreakpoint", {text = "🔴", texthl = "", linehl = "", numhl = ""})
vim.fn.sign_define("DapStopped", {text = "➜", texthl = "", linehl = "", numhl = ""})
