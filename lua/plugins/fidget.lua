return {
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
      progress = {
        poll_rate = 0,
        suppress_on_insert = true,
        ignore_done_already = true,
        display = {
          render_limit = 8,
          done_ttl = 2,
        },
      },
      notification = {
        override_vim_notify = false,
        window = {
          winblend = 0,
        },
      },
    },
  },
}
