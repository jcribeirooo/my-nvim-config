local M = {}

function M.setup()
    require("mason-lspconfig").setup({
        ensure_installed = {
            "lua_ls",
            "golangci_lint_ls",
            "gopls",
            "html",
            "jsonls",
            "yamlls"
        }
    })
end

return M
