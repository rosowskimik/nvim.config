return {
  {
    "m00qek/baleia.nvim",
    version = "*",
    config = function()
      local baleia = require("baleia").setup({})

      -- Command to colorize the current buffer
      vim.api.nvim_create_user_command("BaleiaColorize", function()
        baleia.once(vim.api.nvim_get_current_buf())
      end, { bang = true })

      vim.api.nvim_create_autocmd("BufWinEnter", {
        group = vim.api.nvim_create_augroup("plugin-baleia", { clear = true }),
        pattern = { "*.log", "*.dump" },
        callback = function()
          baleia.automatically(vim.api.nvim_get_current_buf())
        end,
      })
    end,
  },
}
