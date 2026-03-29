return {
  {
    "chomosuke/typst-preview.nvim",
    version = "1.*",
    ft = "typst",
    opts = {
      dependencies_bin = {
        ["tinymist"] = "tinymist",
      },
    },
    keys = {
      { "<leader>tp", "<cmd>TypstPreviewToggle<CR>", ft = "typst", desc = "Toggle typst preview" },
      { "<leader>ts", "<cmd>TypstPreviewSyncCursor<CR>", ft = "typst", desc = "Sync cursor in preview" },
    },
  },
}
