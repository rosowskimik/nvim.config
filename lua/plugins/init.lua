return require("packer").startup({
  function(use)
    use("lewis6991/impatient.nvim")
    use("wbthomason/packer.nvim")
    use({
      "EdenEast/nightfox.nvim",
      config = function()
        require("colors")
      end,
    })

    --use {
    --  'ThePrimeagen/refactoring.nvim',
    --  requires = {
    --    {'nvim-lua/plenary.nvim'},
    --    {'nvim-treesitter/nvim-treesitter'},
    --  },
    --  config = function()
    --    require('plugins.refactoring')
    --  end,
    --}
    --
    -- use("tjdevries/cyclist.vim")

    use({
      "mhinz/vim-sayonara",
      config = function()
        require("plugins.sayonara")
      end,
    })

    -- use({
    -- 	"phaazon/hop.nvim",
    -- 	branch = "v1",
    -- 	config = function()
    -- 		require("plugins.hop")
    -- 	end,
    -- })

    use("ggandor/lightspeed.nvim")

    use("gpanders/nvim-parinfer")

    use({
      "voldikss/vim-floaterm",
      config = function()
        require("plugins.floaterm")
      end,
    })

    use({
      "lewis6991/gitsigns.nvim",
      requires = {
        "nvim-lua/plenary.nvim",
      },
      config = function()
        require("gitsigns").setup()
      end,
    })

    use("tpope/vim-surround")
    use("tpope/vim-sleuth")

    use({
      "numToStr/Comment.nvim",
      config = function()
        require("plugins.comment")
      end,
    })

    use("kyazdani42/nvim-web-devicons")

    use({
      "akinsho/bufferline.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("plugins.bufferline")
      end,
    })

    use({
      "nvim-lualine/lualine.nvim",
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
      config = function()
        require("plugins.lualine")
      end,
    })

    use({
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        require("plugins.indent_blankline")
      end,
    })

    use({
      "nvim-treesitter/nvim-treesitter",
      requires = {
        "JoosepAlviste/nvim-ts-context-commentstring",
        "windwp/nvim-ts-autotag",
        "andymass/vim-matchup",
        "p00f/nvim-ts-rainbow",
        "nvim-treesitter/nvim-treesitter-textobjects",
      },
      run = function()
        pcall(require("nvim-treesitter.install").update({ with_sync = true }))
      end,
      config = function()
        require("plugins.treesitter")
      end,
    })

    use({
      "windwp/nvim-autopairs",
      config = function()
        require("plugins.autopairs")
      end,
    })

    use({
      "lukas-reineke/lsp-format.nvim",
      config = function()
        require("plugins.lspformat")
      end,
    })

    use({
      "kyazdani42/nvim-tree.lua",
      requires = {
        "kyazdani42/nvim-web-devicons",
      },
      config = function()
        require("plugins.nvimtree")
      end,
    })

    use({
      "ThePrimeagen/harpoon",
      requires = {
        "nvim-lua/plenary.nvim",
      },
      config = function()
        require("plugins.harpoon")
      end,
    })

    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make", cond = vim.fn.executable("make") == 1 })

    use({
      "nvim-telescope/telescope.nvim",
      requires = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        "ThePrimeagen/harpoon",
      },
      config = function()
        require("plugins.telescope")
      end,
    })

    use("andymass/vim-matchup")

    use({
      "simrat39/symbols-outline.nvim",
      config = function()
        require("plugins.outline")
      end,
    })

    use("antoinemadec/FixCursorHold.nvim")

    use("simrat39/rust-tools.nvim")

    -- use("fatih/vim-go")

    use({
      "neovim/nvim-lspconfig",
      requires = {
        "onsails/lspkind-nvim",
        "hrsh7th/cmp-nvim-lsp",
        "simrat39/rust-tools.nvim",
        "ray-x/lsp_signature.nvim",
        "lukas-reineke/lsp-format.nvim",
      },
      config = function()
        require("plugins.lspconfig")
      end,
    })

    use({
      "mfussenegger/nvim-lint",
      config = function()
        require("plugins.nvim-lint")
      end,
    })

    use({
      "folke/trouble.nvim",
      require = {
        "kyazdani42/nvim-web-devicons",
      },
      config = function()
        require("plugins.trouble")
      end,
    })

    use({
      "L3MON4D3/LuaSnip",
      require = {
        "nvim-treesitter/nvim-treesitter",
      },
      config = function()
        require("plugins.luasnip")
      end,
    })

    use({
      "hrsh7th/nvim-cmp",
      require = {
        "onsails/lspkind-nvim",
        "windwp/nvim-autopairs",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-path",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
      },
      config = function()
        require("plugins.cmp")
      end,
    })

    use({
      "cespare/vim-toml",
      ft = { "toml" },
    })

    use({
      "plasticboy/vim-markdown",
      ft = { "markdown" },
    })
  end,
  config = {
    compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
  },
})
