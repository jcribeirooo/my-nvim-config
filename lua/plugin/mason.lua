local M = {}

function M.setup()
    require("mason").setup({
        ui = {
            border = "rounded",
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗"
            }
        }
    })
    require("mason-lspconfig").setup {
        ensure_installed = {
            "lua_ls",
            "tsserver",
            "html",
            "golangci_lint_ls",
            "gopls"
        },
    }
end

return M
