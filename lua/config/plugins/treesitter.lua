return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    dependencies = {
      {
        "andymass/vim-matchup",
        init = function()
          vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end,
      },
    },
    config = function()
      local ts = require("nvim-treesitter")
      local ensure_installed = {
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
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "ssh_config",
        "tmux",
        "toml",
        "vim",
        "vimdoc",
        "zsh",
      }

      ts.setup()
      ts.install(ensure_installed):wait(300000)

      local languages = ts.get_installed()

      vim.api.nvim_create_autocmd("FileType", {
        pattern = languages,
        callback = function()
          vim.treesitter.start()

          vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.wo.foldmethod = "expr"
          vim.wo.foldlevel = 99

          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
}
