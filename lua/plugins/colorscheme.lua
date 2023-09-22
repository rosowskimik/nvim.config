return {
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.rehash256 = 1
      vim.opt.termguicolors = true
      -- Nightfox theme
      vim.cmd("colorscheme nightfox")
    end,
  }
}
