return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
      {
        "andymass/vim-matchup",
        opts = {
          matchparen = {
            offscreen = {
              method = "popup",
            },
          },
        },
      },
    },
    config = function()
      local ts = require("nvim-treesitter")

      local ensure_installed = {
        "bash",
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
      ts.install(ensure_installed)

      vim.api.nvim_create_autocmd("FileType", {
        desc = "Enable treesitter for supported languages",
        pattern = ts.get_installed(),
        group = vim.api.nvim_create_augroup("user-treesitter", { clear = true }),
        callback = function()
          vim.treesitter.start()

          vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.wo.foldmethod = "expr"

          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
}
