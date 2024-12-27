return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        pickers = {
          keymaps = {
            theme = "dropdown",
          },
          current_buffer_fuzzy_find = {
            theme = "dropdown",
            previewer = false,
          },
          find_files = {
            theme = "ivy",
          },
          lsp_definitions = {
            theme = "ivy",
          },
          lsp_references = {
            theme = "ivy",
          },
          lsp_implementations = {
            theme = "ivy",
          },
          lsp_type_definitions = {
            theme = "ivy",
          },
        },
      })

      telescope.load_extension("fzf")
    end,
    keys = {
      {
        "<leader>sk",
        require("telescope.builtin").keymaps,
        desc = "[S]earch [K]eymaps",
      },
      {
        "<leader>sf",
        require("telescope.builtin").find_files,
        desc = "[S]earch [F]iles",
      },
      {
        "<leader>sg",
        function()
          require("config.telescope.multigrep").live_multigrep(require("telescope.themes").get_ivy())
        end,
        desc = "[S]earch Directory with [G]rep",
      },
      {
        "<leader>sb",
        require("telescope.builtin").current_buffer_fuzzy_find,
        desc = "[S]earch [B]uffer",
      },
      {
        "<leader>sn",
        function()
          require("telescope.builtin").find_files({
            cwd = vim.fn.stdpath("config"),
          })
        end,
        desc = "[S]earch [N]eovim",
      },
    },
  },
}
