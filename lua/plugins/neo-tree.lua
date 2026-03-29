return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    opts = function(_, opts)
      local function on_move(data)
        Snacks.rename.on_rename_file(data.source, data.destination)
      end
      local events = require("neo-tree.events")
      opts.event_handlers = opts.event_handlers or {}
      vim.list_extend(opts.event_handlers, {
        { event = events.FILE_MOVED, handler = on_move },
        { event = events.FILE_RENAMED, handler = on_move },
      })
      opts.close_if_last_window = true
      opts.default_component_configs = {
        name = { trailing_slash = true },
      }
      opts.filesystem = {
        filtered_items = { visible = true },
        use_libuv_file_watcher = true,
        follow_current_file = { enabled = true },
      }
    end,
    keys = {
      {
        "<leader>e",
        "<cmd>Neotree toggle<CR>",
        desc = "Toggle file explorer",
      },
      {
        "<leader>ge",
        "<cmd>Neotree float git_status<CR>",
        desc = "Git status (neo-tree)",
      },
    },
  },
}
