return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "andymass/vim-matchup",
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "bitbake",
          "c",
          "cmake",
          "comment",
          "cpp",
          "devicetree",
          "diff",
          "dockerfile",
          "git_config",
          "git_rebase",
          "gitattributes",
          "gitcommit",
          "gitignore",
          "go",
          "gomod",
          "gosum",
          "gowork",
          "json",
          "jsonc",
          "lua",
          "make",
          "markdown",
          "markdown_inline",
          "python",
          "rst",
          "rust",
          "sql",
          "toml",
          "vim",
          "vimdoc",
          "yaml",
          "zig",
        },
        -- sync_install = true,

        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<c-space>",
            node_incremental = "<c-space>",
            scope_incremental = "<c-s>",
            node_decremental = "<c-backspace>",
          },
        },

        -- Extended modules
        matchup = { enable = true },
      })
    end,
  },
}
