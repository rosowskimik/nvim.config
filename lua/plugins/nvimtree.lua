local g = vim.g

require("nvim-tree").setup({
  actions = {
    open_file = {
      quit_on_open = true,
      window_picker = {
        enable = false,
        exclude = {
          filetype = { "notify", "packer", "qf" },
          buftype = { "terminal", "nofile", "help" },
        },
      },
    },
  },
  renderer = {
    indent_markers = {
      enable = true,
    },
    highlight_git = true,
    group_empty = true,
    add_trailing = true,
    highlight_opened_files = "all",
  },
})

K("n", "<leader>e", ":NvimTreeToggle<CR>")
