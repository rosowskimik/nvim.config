return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      {
        'andymass/vim-matchup',
        init = function()
          vim.g.matchup_matchparen_offscreen = { method = 'popup' }
        end,
      },
    },

    config = function()
      local languages = {
        'asm',
        'bash',
        'bitbake',
        'c',
        'cmake',
        'comment',
        'cpp',
        'devicetree',
        'diff',
        'disassembly',
        'dockerfile',
        'doxygen',
        'git_config',
        'git_rebase',
        'gitattributes',
        'gitcommit',
        'gitignore',
        'go',
        'gomod',
        'gosum',
        'gowork',
        'html',
        'hyprlang',
        'ini',
        'json',
        'jsonc',
        'kconfig',
        'linkerscript',
        'lua',
        'make',
        'markdown',
        'markdown_inline',
        'python',
        'rst',
        'rust',
        'sql',
        'ssh_config',
        'tmux',
        'toml',
        'vim',
        'vimdoc',
        'yaml',
        'zig',
      }

      require('nvim-treesitter.configs').setup {
        ensure_installed = languages,
        highlight = { enable = true },
        indent = { enable = true },
        matchup = { enable = true, disable_virtual_text = false },
      }
    end,
  },
}
