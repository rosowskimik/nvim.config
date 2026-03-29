local function augroup(name)
  return vim.api.nvim_create_augroup("user-" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("BufRead", {
  desc = "Restore cursor position",
  group = augroup("restore-cursor"),
  callback = function(opts)
    vim.api.nvim_create_autocmd("BufWinEnter", {
      once = true,
      buffer = opts.buf,
      callback = function()
        local ft = vim.bo[opts.buf].filetype
        local last_line = vim.api.nvim_buf_get_mark(opts.buf, '"')[1]
        local line_count = vim.api.nvim_buf_line_count(opts.buf)

        if ft:match("commit") or ft:match("rebase") then
          return
        end

        if last_line > 1 and last_line <= line_count then
          vim.api.nvim_feedkeys([[g`"]], "nx", false)
        end
      end,
    })
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  desc = "Disable line numbers in terminal buffers",
  group = augroup("terminal"),
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
  end,
})

vim.api.nvim_create_autocmd("BufRead", {
  desc = "Open .orig files as readonly",
  pattern = { "*.orig", "*.bak", "*.bck" },
  group = augroup("filetypes"),
  callback = function()
    vim.bo.readonly = true
  end,
})
