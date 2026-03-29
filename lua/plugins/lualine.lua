-- Macro recording indicator: store state via autocmd to avoid
-- the reg_recording() timing issue on RecordingLeave
local macro_reg = ""
vim.api.nvim_create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
  group = vim.api.nvim_create_augroup("user-lualine-macro", { clear = true }),
  callback = function(ev)
    macro_reg = ev.event == "RecordingLeave" and "" or vim.fn.reg_recording()
    require("lualine").refresh({ place = { "statusline" } })
  end,
})

return {
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    opts = {
      options = {
        theme = "auto",
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = {
          -- Macro recording indicator
          {
            function()
              return macro_reg ~= "" and ("Recording @" .. macro_reg) or ""
            end,
            color = { fg = "#ff9e64" },
            draw_empty = false,
          },
          "searchcount",
          "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      extensions = { "lazy", "neo-tree", "quickfix", "trouble" },
    },
  },
}
