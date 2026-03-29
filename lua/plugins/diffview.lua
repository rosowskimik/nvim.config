return {
  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewFileHistory",
      "DiffviewToggleFiles",
    },
    opts = {
      enhanced_diff_hl = true,
    },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diff view open" },
      { "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Diff view close" },
      { "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "File history (repo)" },
      { "<leader>gH", "<cmd>DiffviewFileHistory %<cr>", desc = "File history (current)" },
    },
  },
}
