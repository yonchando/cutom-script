local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

vim.cmd [[
augroup packer_user_config
autocmd!
autocmd BufWritePost packer.lua source <afile> | PackerInstall
augroup end
]]

local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

return packer.startup({
    function(use)
        -- Packer can manage itself
        use 'wbthomason/packer.nvim'

        use({ 'nvim-treesitter/nvim-treesitter', run = ":TSUpdate" })

        use({
            "nvim-treesitter/nvim-treesitter-textobjects",
            after = "nvim-treesitter",
            requires = "nvim-treesitter/nvim-treesitter",
        })

        use {
            'nvim-telescope/telescope.nvim', tag = '0.1.2',
            requires = { { 'nvim-lua/plenary.nvim' } }
        }

        use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

        -- Cmp
        use { "hrsh7th/nvim-cmp" }         -- The completion plugin
        use { "hrsh7th/cmp-buffer" }       -- buffer completions
        use { "hrsh7th/cmp-path" }         -- path completions
        use { "hrsh7th/cmp-cmdline" }      -- path completions
        use { "saadparwaiz1/cmp_luasnip" } -- snippet completions
        use { "hrsh7th/cmp-nvim-lsp" }
        use { "hrsh7th/cmp-nvim-lua" }

        -- Snippets
        use { "L3MON4D3/LuaSnip" }             --snippet engine
        use { "rafamadriz/friendly-snippets" } -- a bunch of snippets to use

        -- LSP
        use { "williamboman/mason.nvim" }         -- simple to use language server installer
        use { "williamboman/mason-lspconfig.nvim" }
        use { "neovim/nvim-lspconfig" }           -- enable LSP
        use { "jose-elias-alvarez/null-ls.nvim" } -- for formatters and linters


        use { "windwp/nvim-autopairs" }

        use { 'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons' }

        use({ 'dracula/vim', as = 'dracula', config = function() vim.cmd("colorscheme dracula") end })

        use 'goolord/alpha-nvim'

        use 'nvim-tree/nvim-tree.lua'
        use 'nvim-tree/nvim-web-devicons'

        use "lukas-reineke/indent-blankline.nvim"

        use 'numToStr/Comment.nvim'

        use {
            'nvim-lualine/lualine.nvim',
            requires = { 'nvim-tree/nvim-web-devicons', opt = true }
        }

        use "folke/which-key.nvim"

        use "christoomey/vim-tmux-navigator"

        use({
            "kylechui/nvim-surround",
            tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        })

        use { 'mg979/vim-visual-multi', branch = 'master' }

        use { "moll/vim-bbye" }

        use { "akinsho/toggleterm.nvim", tag = '*' }

        use { "folke/neodev.nvim" }

        use { "dcampos/cmp-emmet-vim" }

        use "mfussenegger/nvim-jdtls"

        use 'famiu/bufdelete.nvim'

        use {
            'adalessa/laravel.nvim',
            requires = {
                'tpope/vim-dotenv',
                'MunifTanjim/nui.nvim',
            }
        }

        use 'lewis6991/gitsigns.nvim'

        use 'easymotion/vim-easymotion'

        use {'nvim-telescope/telescope-ui-select.nvim' }

        if packer_bootstrap then
            require('packer').sync()
        end
    end,
    config = {
        display = {
            open_fn = function()
                return require("packer.util").float { border = "rounded" }
            end,
        },
    }
})
