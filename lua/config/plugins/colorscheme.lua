return {
  {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    config = function()
      vim.g.rehash256 = 1
      vim.opt.termguicolors = true

      require("nightfox").setup({
        options = {
          styles = {
            comments = "italic",
            constants = "bold",
            types = "italic",
          },
        },
        groups = {
          nightfox = {
            CursorLine = { bg = "#1f2c3d" },
            LspInlayHint = { link = "NonText" },
            LspReferenceText = { style = "underline" },
            LspReferenceRead = { style = "underline" },
            LspReferenceWrite = { style = "underline" },
            NormalFloat = { link = "Normal" },
            -- Plugins
            BlinkCmpGhostText = { link = "NonText" },
            MiniCursorword = { style = "underline" },
            MiniCursorwordCurrent = { style = "underline" },
          },
        },
      })
      vim.cmd("colorscheme nightfox")
    end,
  },
}
