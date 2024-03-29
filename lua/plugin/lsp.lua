local M = {}

function M.setup()
    local lsp = require("lsp-zero")
    lsp.preset("recommended")
    lsp.nvim_workspace()
    local cmp = require('cmp')
    cmp.setup({
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        }
    })
    require("luasnip.loaders.from_vscode").lazy_load()
    local cmp_select = {behavior = cmp.SelectBehavior.Select}
    local cmp_mappings = lsp.defaults.cmp_mappings({
        ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
        ['<Enter>'] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
    })
    lsp.setup_nvim_cmp({
        mapping = cmp_mappings
    })
    lsp.set_preferences({
        suggest_lsp_servers = true,
        sign_icons = {
            error = '',
            warn = '',
            hint = '',
            info = ''
        }
    })
    lsp.on_attach(function(_, bufnr)
        local opts = {buffer = bufnr, remap = false}
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function()
            if require'dap'.session() then
                require("dapui").eval()
            else
                vim.lsp.buf.hover()
            end
        end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    end)
    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
        vim.lsp.handlers.hover,
        {border = 'rounded'}
    )
    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        {border = 'rounded'}
    )
    lsp.setup()
    vim.diagnostic.config({
        virtual_text = true
    })
    local lspconfig = require('lspconfig')
    lspconfig.jdtls.setup {
        autostart = false,
        cmd = { "echo", "1"},
    }
end

return M
