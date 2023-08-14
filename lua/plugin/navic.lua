local M = {}

function M.setup()
    local navic = require("nvim-navic")
    navic.setup {
        lsp = {
            auto_attach = true
        }
    }
end

return M
