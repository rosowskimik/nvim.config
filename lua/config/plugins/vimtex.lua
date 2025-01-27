return {
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      vim.g.vimtex_view_method = "zathura_simple"
      vim.g.vimtex_compiler_method = "tectonic"
    end,
    keys = {
      { "<localleader>c", "<cmd>VimtexCompile<CR>" },
      { "<localleader>v", "<cmd>VimtexView<CR>" },
    },
  },
}
