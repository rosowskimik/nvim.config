return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      delay = 500,
      -- Filter out mappings with no desc to reduce noise
      filter = function(mapping)
        return mapping.desc and mapping.desc ~= ""
      end,
      spec = {
        { "<leader>s", group = "Search" },
        { "<leader>g", group = "Git" },
        { "<leader>d", group = "Diagnostics" },
        { "<leader>t", group = "Toggle" },
        { "<leader>x", group = "Trouble / Quickfix" },
        { "<leader>b", group = "Buffer" },
        { "g", group = "Goto" },
        { "]", group = "Next" },
        { "[", group = "Prev" },
      },
      icons = {
        mappings = true,
        provider = "mini",
      },
      win = {
        border = "single",
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer keymaps",
      },
    },
  },
}
