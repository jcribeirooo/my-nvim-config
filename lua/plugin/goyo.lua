local M = {}

function M.setup()
    function Goyo_enter()
        vim.cmd("hi CursorLine ctermbg=black term=none cterm=none")
        vim.cmd("set number")
        require("lualine").hide()
    end

    function Goyo_leave()
        require("lualine").hide({ unhide = true })
    end

    vim.cmd("autocmd! User GoyoEnter nested lua Goyo_enter()")
    vim.cmd("autocmd! User GoyoLeave nested lua Goyo_leave()")
end

return M
