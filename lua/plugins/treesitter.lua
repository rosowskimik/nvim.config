return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = vim.env.NVIM_TS_PARSERS and "" or ":TSUpdate",
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
    config = function(opts)
      local ts = require("nvim-treesitter")

      if vim.env.NVIM_TS_PARSERS == nil then
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
      else
        ts.setup({ install_dir = vim.env.NVIM_TS_PARSERS })
      end

      vim.api.nvim_create_autocmd("FileType", {
        desc = "Enable treesitter for supported languages",
        group = vim.api.nvim_create_augroup("user-treesitter", { clear = true }),
        callback = function(args)
          local buf = args.buf
          if vim.bo[buf].buftype ~= "" then
            return
          end

          local lang = vim.treesitter.language.get_lang(args.match)
          if not lang then
            return
          end

          local ok, added = pcall(vim.treesitter.language.add, lang)
          if not ok or not added then
            vim.print("Parser for " .. lang .. "not found!")
            return
          end

          vim.treesitter.start(args.buf, lang)

          vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.wo[0][0].foldmethod = "expr"

          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
}
