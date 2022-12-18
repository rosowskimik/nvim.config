local comment = require("Comment")
comment.setup({
  toggler = {
    line = "<C-_>",
    block = "<C-\\>",
  },
})

-- K("v", "<C-_>", ':lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>')
-- K("v", "<C-\\>", ':lua require("Comment.api").toggle.blockwise(vim.fn.visualmode())<CR>')
local api = require("Comment.api")
local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)

K("v", "<C-_>", function()
  vim.api.nvim_feedkeys(esc, "nx", false)
  api.toggle.linewise(vim.fn.visualmode())
end)
K("v", "<C-\\>", function()
  vim.api.nvim_feedkeys(esc, "nx", false)
  api.toggle.blockwise(vim.fn.visualmode())
end)
