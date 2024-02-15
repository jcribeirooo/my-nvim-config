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

vim.api.nvim_set_keymap("n", "<F10>", ":Goyo<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "`", function()
    require("dap").toggle_breakpoint()
end)

function RunDebugger()
    if require("dap").session() then
        require("dap").continue()
    else
        local ts = require("dap-go-ts")
        local test = ts.closest_test()
        if test.name ~= "" then
            require("dap-go").debug_test()
            return
        end
        if require("dap-go").last_testname == "" then
            require("dap-go").debug_test()
        else
            require("dap-go").debug_last_test()
        end
    end
end

vim.keymap.set("n", "<F5>", RunDebugger)
vim.keymap.set("n", "<F6>", function()
    require("dap").step_over()
end)
vim.keymap.set("n", "<F7>", function()
    require("dap").step_into()
end)
vim.keymap.set("n", "<F8>", function()
    require("dap").step_out()
end)

vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "➜", texthl = "", linehl = "", numhl = "" })
vim.keymap.set("n", "<leader>do", function()
    require("dapui").open()
end)
vim.keymap.set("n", "<leader>dc", function()
    require("dapui").close()
end)

-- Function to toggle wrap option
function Toggle_wrap()
    local wrap_option = vim.wo.wrap -- Get the current value of wrap
    vim.wo.wrap = not wrap_option -- Toggle the wrap option
end

-- Bind the toggle_wrap function to a key, for example, <C-w>
vim.api.nvim_set_keymap("n", "<C-w>", ":lua Toggle_wrap()<CR>", { noremap = true, silent = true })

function Nvimtree_find_buffer()
    local buf = vim.api.nvim_get_current_buf()
    local bufname = vim.api.nvim_buf_get_name(buf)
    if vim.fn.isdirectory(bufname) or vim.fn.isfile(bufname) then
        require("nvim-tree.api").tree.find_file(vim.fn.expand("%:p"))
    end
end

vim.api.nvim_set_keymap("n", "<leader><S-f>", ":lua Nvimtree_find_buffer()<CR>", { noremap = true, silent = true })

function Toggle_dapui()
    local dapui = require("dapui")
    local nvimtree = require("nvim-tree.api")
    nvimtree.tree.close()
    dapui.toggle()
end

vim.api.nvim_set_keymap("n", "<F12>", ":lua Toggle_dapui()<CR>", { noremap = true, silent = true })
