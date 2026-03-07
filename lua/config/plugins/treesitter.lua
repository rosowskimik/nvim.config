return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    -- branch = "main",
    dependencies = {
      {
        "andymass/vim-matchup",
        init = function()
          vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end,
      },
    },
    opts = {
      ensure_installed = {
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
      },
      highlight = { enable = true },
      indent = { enable = true },
      matchup = { enable = true, disable_virtual_text = false },
    },
  },
}
