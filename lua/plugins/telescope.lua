return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local sorters = require("telescope.sorters")
      local builtin = require("telescope.builtin")

      telescope.setup({
        defaults = {
          file_sorter = sorters.get_fzy_sorter,
          prompt_prefix = " >",
          color_devicons = true,

          mappings = {
            i = {
              ["<C-x>"] = false,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<M-j>"] = actions.move_selection_next,
              ["<M-k>"] = actions.move_selection_previous,
              ["<C-q>"] = actions.send_to_qflist,
              ["<C-_>"] = actions.close,
            },
            n = {
              ["<C-q>"] = actions.send_to_qflist,
              ["q"] = actions.close,
              ["<C-_>"] = actions.close,
            },
          },
          -- pickers = {
          -- 	file_browser = {
          -- 		hidden = true,
          -- 	},
          -- },
        },
      })
    end,
    keys = {
      {
        "<leader>fd",
        function()
          local config_var = ""
          if vim.fn.has("unix") then
            config_var = "XDG_CONFIG_HOME"
          else
            config_var = "LOCALAPPDATA"
          end
          require("telescope.builtin").find_files({
            prompt_title = "< Nvim Config >",
            cwd = os.getenv(config_var) .. "/nvim",
            hidden = true,
          })
        end,
      },
      {
        "<leader>fe",
        function()
          require("telescope.builtin").find_files({ hidden = true })
        end,
      },
      {
        "<leader>ff",
        function()
          require("telescope.builtin").current_buffer_fuzzy_find()
        end,
      },
      {
        "<leader>gs",
        function()
          require("telescope.builtin").grep_string({ search = vim.fn.expand("<cexpr>") })
        end,
      },
      {
        "<leader>lg",
        function()
          require("telescope.builtin").live_grep()
        end,
      },
      {
        "gd",
        function()
          require("telescope.builtin").lsp_definitions()
        end,
      },
      {
        "gt",
        function()
          require("telescope.builtin").lsp_type_definitions()
        end,
      },
      {
        "gi",
        function()
          require("telescope.builtin").lsp_implementations()
        end,
      },
      {
        "gr",
        function()
          require("telescope.builtin").lsp_references()
        end,
      },
    },
  },
}
