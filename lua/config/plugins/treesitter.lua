return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      {
        "andymass/vim-matchup",
        init = function()
          vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end,
      },
    },

    config = function()
      local languages = {
        "bash",
        "comment",
        "diff",
        "editorconfig",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "hyprlang",
        "json",
        "jsonc",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "ssh_config",
        "tmux",
        "toml",
        "vim",
        "vimdoc",
      }

      require("nvim-treesitter.configs").setup({
        ensure_installed = languages,
        highlight = { enable = true },
        indent = { enable = true },
        matchup = { enable = true, disable_virtual_text = false },
      })
    end,
  },
}
