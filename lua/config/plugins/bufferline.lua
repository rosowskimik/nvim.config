return {
  {
    "akinsho/bufferline.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        offsets = {
          { filetype = "Neotree", text = "File Explorer", text_align = "center" },
        },
        diagnostics = "nvim_lsp",
      },
    },
    keys = {
      { "<leader><leader>", ":BufferLinePick<CR>" },
    },
  },
}
