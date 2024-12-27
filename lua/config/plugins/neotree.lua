return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
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
          event = "file_opened",
          handler = function()
            require("neo-tree.command").execute({ action = "close" })
          end,
        },
      },
    },
    keys = {
      { "<leader>E", ":Neotree reveal<CR>" },
    },
  },
}
