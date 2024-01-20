return {
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
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
      })

      vim.cmd("colorscheme nightfox")
    end,
  },
}
