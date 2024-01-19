-- return {
--   {
--     "EdenEast/nightfox.nvim",
--     lazy = false,
--     priority = 1000,
--     config = function()
--       vim.g.rehash256 = 1
--       vim.opt.termguicolors = true
--       -- Nightfox theme
--       vim.cmd("colorscheme nightfox")
--     end,
--   },
-- }
return {
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.rehash256 = 1
      vim.opt.termguicolors = true

      vim.g.gruvbox_material_foreground = "original"
      vim.g.gruvbox_material_background = "hard"

      vim.cmd("colorscheme gruvbox-material")
    end,
  }
}
