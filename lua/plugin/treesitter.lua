local M = {}

function M.setup()
    local configs = require("nvim-treesitter.configs")
    configs.setup({
        ensure_installed = {
            "c",
            "lua",
            "vim",
            "vimdoc",
            "javascript",
            "html",
            "java",
            "go",
        },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
    })
end

return M
