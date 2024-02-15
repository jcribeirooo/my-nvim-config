local M = {}

function M.setup()
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>f", function()
        builtin.find_files({ no_ignore = true })
    end, {})
    vim.keymap.set("n", "<leader>/", function()
        builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end)
end

return M
