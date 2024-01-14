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
  },
}
-- return {
--   {
--     "ellisonleao/gruvbox.nvim",
--     lazy = "false",
--     priority = 1000,
--     config = function()
--       require("gruvbox").setup({
--         contrast = "hard",
--       })
--
--       vim.g.rehash256 = 1
--       vim.opt.termguicolors = true
--
--       vim.cmd("colorscheme gruvbox")
--     end,
--   },
-- }
