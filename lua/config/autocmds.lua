-- Restore cursor position
vim.api.nvim_create_autocmd("BufRead", {
  callback = function(opts)
    vim.api.nvim_create_autocmd("BufWinEnter", {
      desc = "Restore cursor position",
      once = true,
      buffer = opts.buf,
      callback = function()
        local ft = vim.bo[opts.buf].filetype
        local last_known_line = vim.api.nvim_buf_get_mark(opts.buf, '"')[1]
        if
          not (ft:match("commit") and ft:match("rebase"))
          and last_known_line > 1
          and last_known_line <= vim.api.nvim_buf_line_count(opts.buf)
        then
          vim.api.nvim_feedkeys([[g`"]], "nx", false)
        end
      end,
    })
  end,
})

-- Disable line numbers in terminal mode
vim.api.nvim_create_autocmd("TermOpen", {
  desc = "Disable line numbers in terminal mode",
  group = vim.api.nvim_create_augroup("opt-term-open", { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

-- Autoclose terminal window on process exit
vim.api.nvim_create_autocmd("TermClose", {
  desc = "Auto close terminal on exit",
  group = vim.api.nvim_create_augroup("opt-term-close", { clear = true }),
  callback = function()
    vim.cmd("bdelete")
  end,
})

-- Set filetype for assembly
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  desc = "Set filetype for assmebly files",
  pattern = "*.S",
  group = vim.api.nvim_create_augroup("opt-set-filetype", { clear = true }),
  command = "set ft=asm",
})

-- Set 'orig' files as readonly
vim.api.nvim_create_autocmd("BufRead", {
  desc = "Set 'orig' files as readonly",
  pattern = "*.orig",
  group = vim.api.nvim_create_augroup("opt-readonly-orig", { clear = true }),
  command = "set readonly",
})
