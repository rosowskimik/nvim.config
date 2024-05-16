return {
  {
    'folke/lazy.nvim',
    version = '*',
  },

  -- Detect tabstop & shiftwidth automatically
  'tpope/vim-sleuth',

  {
    'folke/twilight.nvim',
    config = true,
  },

  {
    'aserowy/tmux.nvim',
    config = true,
    keys = { '<C-h>', '<C-j>', '<C-k>', '<C-l>', '<M-h>', '<M-j>', '<M-k>', '<M-l>' },
  },

  {
    'ggandor/leap.nvim',
    config = function()
      require('leap').add_default_mappings(true)
    end,
  },

  {
    'mhinz/vim-sayonara',
    cmd = 'Sayonara',
    keys = {
      { '<leader>q', '<cmd>Sayonara<CR>' },
    },
  },

  {
    'lewis6991/gitsigns.nvim',
    config = true,
  },

  {
    'akinsho/git-conflict.nvim',
    version = '*',
    config = function()
      require('git-conflict').setup()

      vim.api.nvim_create_autocmd('User', {
        desc = 'Start conflict buster mode',
        pattern = 'GitConflictDetected',
        callback = function()
          vim.notify('Conflict detected in ' .. vim.fn.expand '<afile>' .. " Start conflict buster with 'cww'.")
          vim.keymap.set('n', 'cww', function()
            ---@diagnostic disable-next-line: undefined-global
            engage.conflict_buster()
            ---@diagnostic disable-next-line: undefined-global
            create_buffer_local_mappings()
          end)
        end,
      })
    end,
  },

  {
    'numToStr/FTerm.nvim',
    opts = {
      dimensions = {
        height = 1.0,
        width = 1.0,
      },
    },
    keys = {
      {
        '<A-t>',
        function()
          require('FTerm').toggle()
        end,
        desc = '[T]oggle terminal',
      },
      {
        '<A-t>',
        function()
          require('FTerm').toggle()
        end,
        mode = 't',
        desc = '[T]oggle terminal',
      },
      {
        '<leader>g',
        function()
          require('FTerm').scratch {
            cmd = 'lazygit',
            dimensions = {
              height = 1.0,
              width = 1.0,
            },
          }
        end,
        desc = 'Open Lazy[G]it',
      },
    },
  },

  {
    'numToStr/Comment.nvim',
    dependencies = {
      {
        'JoosepAlviste/nvim-ts-context-commentstring',
        init = function()
          vim.g.skip_ts_context_commentstring_module = true
        end,
      },
    },
    config = function()
      require('Comment').setup {
        toggler = {
          line = '<C-_>',
          block = '<C-\\>',
        },
        opleader = {
          line = '<C-_>',
          block = '<C-\\>',
        },
        mappings = {
          basic = true,
          extra = false,
        },
        ignore = '^$',
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end,
    keys = {
      { '<C-_>', desc = 'Toggle current line comment' },
      { '<C-\\>', desc = 'Toggle current line block comment' },
      { '<C-_>', mode = 'v', desc = 'Toggle selection line comment' },
      { '<C-\\>', mode = 'v', desc = 'Toggle selection block comment' },
      {
        '<C-/>',
        function()
          require('Comment.api').toggle.linewise.current()
        end,
        desc = 'Toggle current line comment',
      },
      {
        '<C-/>',
        function()
          local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
          local api = require 'Comment.api'

          vim.api.nvim_feedkeys(esc, 'nx', false)
          api.toggle.linewise(vim.fn.visualmode())
        end,
        mode = 'v',
        desc = 'Toggle selection line comment',
      },
    },
  },

  {
    'akinsho/bufferline.nvim',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        offsets = {
          { filetype = 'Neotree', text = 'File Explorer', text_align = 'center' },
        },
        diagnostics = 'nvim_lsp',
      },
    },
    keys = {
      { '<leader><leader>', ':BufferLinePick<CR>' },
    },
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = { theme = 'nightfox' },
      sections = {
        lualine_x = { 'searchcount', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      extensions = { 'neo-tree', 'quickfix', 'symbols-outline' },
    },
  },

  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      view_options = {
        show_hidden = true,
      },
    },
    keys = {
      { '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' } },
    },
  },

  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    },
    opts = {
      close_if_last_window = true,
      default_component_configs = {
        name = { trailing_slash = true },
      },
      filesystem = {
        filtered_items = { visible = true },
        use_libuv_file_watcher = true,
      },
      event_handlers = {
        {
          event = 'file_opened',
          handler = function()
            require('neo-tree.command').execute { action = 'close' }
          end,
        },
      },
    },
    keys = {
      { '<leader>e', ':Neotree reveal<CR>' },
    },
  },

  {
    'folke/todo-comments.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    event = 'VeryLazy',
    opts = {
      signs = false,
    },
  },

  {
    'echasnovski/mini.nvim',
    version = '*',
    config = function()
      -- Extended Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Interactive text align
      require('mini.align').setup()

      -- Autopairs
      require('mini.pairs').setup()

      -- Add/delete/replace surroundings
      require('mini.surround').setup {
        mappings = {
          add = 'ya',
          delete = 'yd',
          find = 'yf',
          find_left = 'yF',
          highlight = 'yh',
          replace = 'yr',
          update_n_lines = 'yn',
        },
      }
    end,
  },

  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = true,
    keys = {
      {
        '<leader>tl',
        function()
          require('trouble').toggle 'document_diagnostics'
        end,
        desc = '[T]oggle [L]ocal (document) diagnostics',
      },
      {
        '<leader>tw',
        function()
          require('trouble').toggle 'workspace_diagnostics'
        end,
        desc = '[T]oggle [W]orkspace diagnostics',
      },
      {
        '<leader>tr',
        function()
          require('trouble').toggle 'lsp_references'
        end,
        desc = '[T]oggle [R]eferences',
      },
      {
        '<leader>td',
        function()
          require('trouble').toggle 'lsp_definitions'
        end,
        desc = '[T]oggle [D]efinitions',
      },
      {
        '<leader>tt',
        function()
          require('trouble').toggle 'lsp_type_definitions'
        end,
        desc = '[T]oggle [T]ype definitions',
      },
      {
        '<leader>tq',
        function()
          require('trouble').toggle 'quickfix'
        end,
        desc = '[T]oggle [Q]uickfix list',
      },
    },
  },

  {
    'EdenEast/nightfox.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.rehash256 = 1
      vim.opt.termguicolors = true

      require('nightfox').setup {
        options = {
          styles = {
            comments = 'italic',
            constants = 'bold',
            types = 'italic',
          },
        },
        groups = {
          nightfox = {
            CursorLine = { bg = '#1f2c3d' },
          },
        },
      }

      vim.cmd 'colorscheme nightfox'
    end,
  },
}
