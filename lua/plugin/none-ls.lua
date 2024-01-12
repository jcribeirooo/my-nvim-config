local M = {}

function M.setup()
    local null_ls = require("null-ls")
        null_ls.setup ({
        sources = {
            null_ls.builtins.formatting.stylua,
            null_ls.builtins.diagnostics.golangci_lint,
            null_ls.builtins.formatting.goimports,
            null_ls.builtins.formatting.gofumpt,
            null_ls.builtins.formatting.golines
        }
    })
end

return M
