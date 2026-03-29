return {
  {
    "akinsho/bufferline.nvim",
    lazy = false,
    opts = {
      options = {
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            text_align = "center",
            separator = true,
          },
        },
        diagnostics = "nvim_lsp",
        show_buffer_close_icons = false,
        show_close_icons = false,
      },
    },
    keys = {
      { "<leader><leader>", "<cmd>BufferLinePick<cr>", desc = "Pick buffer" },
    },
  },
}
