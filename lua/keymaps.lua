-- [[ Basic Keymaps ]]
-- See `:help vim.keymap.set()`

-- Clean highlight
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Save file
vim.keymap.set('n', '<leader>fs', '<cmd>w<CR>', { desc = '[F]ile [S]ave' })

-- Disagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', 'qd', vim.diagnostic.setloclist, { desc = 'Open [Q]uickfix list [D]iagnostic' })

-- Exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Center search results
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', '#', '#zz')
vim.keymap.set('n', '*', 'ma*`a')
vim.keymap.set('n', 'g*', 'g*zz')

-- Add undo breakpoints at punctuations
vim.keymap.set('i', ',', ',<C-g>u')
vim.keymap.set('i', '.', '.<C-g>u')
vim.keymap.set('i', '!', '!<C-g>u')
vim.keymap.set('i', '?', '?<C-g>u')
vim.keymap.set('i', ';', ';<C-g>u')
vim.keymap.set('i', ':', ':<C-g>u')

-- Move selection up/down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Don't copy replaced text after pasting in visual mode
vim.keymap.set('v', 'p', '"_dP')

-- Keep cursor position after yank
vim.keymap.set('v', 'y', 'ygv<Esc>')

-- Quick append to the end of line
vim.keymap.set('n', '<leader>,', 'maA,<Esc>`a')
vim.keymap.set('n', '<leader>;', 'maA;<Esc>`a')
vim.keymap.set('n', '<leader>:', 'maA:<Esc>`a')

-- Move by visual line
vim.keymap.set('n', 'j', '(v:count > 5 ? "m\'" . v:count : "") . "gj"', { expr = true })
vim.keymap.set('n', 'k', '(v:count > 5 ? "m\'" . v:count : "") . "gk"', { expr = true })
vim.keymap.set('v', 'j', '(v:count > 5 ? "m\'" . v:count : "") . "gj"', { expr = true })
vim.keymap.set('v', 'k', '(v:count > 5 ? "m\'" . v:count : "") . "gk"', { expr = true })

-- Switch buffers with left/right arrows
vim.keymap.set('n', '<Left>', '<cmd>bp<CR>')
vim.keymap.set('n', '<Right>', '<cmd>bn<CR>')
