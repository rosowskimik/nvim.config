-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank { timeout = 500 }
  end,
})

-- Return to last known valid position
vim.api.nvim_create_autocmd('BufReadPost', {
  desc = 'Return to last known valid position',
  group = vim.api.nvim_create_augroup('opt-position-restore', { clear = true }),
  command = [[if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]],
})

-- Return to last known valid position
vim.api.nvim_create_autocmd('BufWinEnter', {
  desc = 'Set tabstop',
  group = vim.api.nvim_create_augroup('opt-set-tabstop', { clear = true }),
  callback = function()
    if vim.o.shiftwidth > 4 and vim.o.tabstop > 4 then
      vim.o.tabstop = 4
      vim.o.shiftwidth = 4
    end
  end,
})

-- Set correct filetypes
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  desc = 'Set filetype for assembly files',
  pattern = '*.S',
  group = vim.api.nvim_create_augroup('opt-set-filetype', { clear = true }),
  command = 'set ft=asm',
})

-- Set 'orig' files as readonly
vim.api.nvim_create_autocmd('BufRead', {
  desc = "Set 'orig' files as readonly",
  pattern = '*.orig',
  group = vim.api.nvim_create_augroup('opt-readonly-orig', { clear = true }),
  command = 'set readonly',
})
