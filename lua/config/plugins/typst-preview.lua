return {
  {
    "chomosuke/typst-preview.nvim",
    version = "1.*",
    ft = "typst",
    cmd = { "TypstPreview", "TypstPreviewToggle" },
    opts = {
      dependencies_bin = {
        ["tinymist"] = "tinymist",
      },
    },
  },
}
