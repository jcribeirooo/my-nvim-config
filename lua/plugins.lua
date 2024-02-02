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

local config = function(plugin)
    return function()
        require(plugin).setup()
    end
end

require("lazy").setup({
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = config("plugin.plenary"),
    },
    {
        "dasupradyumna/midnight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("midnight")
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = config("plugin.treesitter"),
    },
    {
        "kyazdani42/nvim-tree.lua",
        config = config("plugin.nvim-tree"),
    },
    {
        "akinsho/bufferline.nvim",
        dependencies = { "kyazdani42/nvim-tree.lua" },
        config = config("plugin.bufferline"),
    },
    {
        "nvim-tree/nvim-web-devicons",
        config = config("plugin.devicons"),
    },
    {
        "famiu/bufdelete.nvim",
    },
    {
        "windwp/nvim-autopairs",
        config = config("nvim-autopairs"),
    },
    {
        "williamboman/mason-lspconfig.nvim"
    },
    {
        "williamboman/mason.nvim",
        config = config("plugin.mason"),
        dependencies = {
            { "williamboman/mason.nvim" }
        }
    },
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        config = config("plugin.lsp"),
        dependencies = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },
            { "williamboman/mason.nvim" },
            -- Autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lua" },
            { "rafamadriz/friendly-snippets" }
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        requires = { "nvim-tree/nvim-web-devicons", opt = true },
        config = config("plugin.lualine"),
    },
    {
        "SmiteshP/nvim-navic",
        dependencies = { "neovim/nvim-lspconfig" },
        config = config("plugin.navic"),
    },
    {
        "L3MON4D3/LuaSnip",
    },
    {
        "RRethy/vim-illuminate",
        config = config("plugin.illuminate"),
    },
    {
        "nvim-lua/popup.nvim",
    },
    {
        "rcarriga/nvim-notify",
        config = config("notify")
    },
    {
        "nvimtools/none-ls.nvim",
        config = config("plugin.none-ls"),
    },
    {
        "junegunn/goyo.vim",
        config = config("plugin.goyo")
    },
    {
        "klen/nvim-test",
        config = config("nvim-test"),
    },
    {
        "lewis6991/gitsigns.nvim",
        config = config("gitsigns"),
    },
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "leoluz/nvim-dap-go",
        },
        config = config("plugin.debugging"),
    },
    {
        "mfussenegger/nvim-jdtls",
        config = config("plugin.nvim-jdtls")
    },
    {
        "j-hui/fidget.nvim",
        config = config("fidget"),
    }
},
{
    ui = {
		border = "rounded",
    }
})
