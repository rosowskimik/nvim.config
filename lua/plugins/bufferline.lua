local bufferline = require("bufferline")

bufferline.setup({
  options = {
    offsets = {
      { filetype = "NvimTree", text = "File Explorer", text_align = "center" },
    },
    diagnostics = "nvim_lsp",
  },
})

K("n", "<leader><leader>", ":BufferLinePick<CR>")
K("n", "<leader>b", ":BufferLinePick<CR>")
K("n", "<leader>k", ":BufferLineCycleNext<CR>")
K("n", "<leader>j", ":BufferLineCyclePrev<CR>")
