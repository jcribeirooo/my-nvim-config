local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        'nvim-lua/plenary.nvim',
        tag = 'v0.1.3'
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.2',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>f', builtin.find_files, {})
            vim.keymap.set('n', '<leader>/', function ()
                builtin.grep_string({ search = vim.fn.input("Grep > ") });
            end)
        end,
    },
    {
        'navarasu/onedark.nvim',
        priority = 1000,
        config = function()
            vim.cmd.colorscheme 'onedark'
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function () 
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                ensure_installed = { "c", "lua", "vim", "vimdoc", "javascript", "html" },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },  
            })
        end
    },
    {
        'kyazdani42/nvim-tree.lua',
        config = function()
            require("plugin.nvimtree").setup()
        end
    },
    {
        'akinsho/bufferline.nvim',
        dependencies = { 'kyazdani42/nvim-tree.lua' },
        config = function ()
            vim.opt.termguicolors = true
            require("plugin.bufferline").setup()
        end
    },
    {
        'nvim-tree/nvim-web-devicons',
        config = function ()
            require'nvim-web-devicons'.setup {
                override = {
                    zsh = {
                        icon = "",
                        color = "#428850",
                        cterm_color = "65",
                        name = "Zsh"
                    }
                };
                color_icons = true;
                default = true;
                strict = true;
                override_by_filename = {
                    [".gitignore"] = {
                        icon = "",
                        color = "#f1502f",
                        name = "Gitignore"
                    }
                };
                override_by_extension = {
                    ["log"] = {
                        icon = "",
                        color = "#81e043",
                        name = "Log"
                    }
                };
            }
        end
    },
    {
        'famiu/bufdelete.nvim'
    },
    {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }
})
