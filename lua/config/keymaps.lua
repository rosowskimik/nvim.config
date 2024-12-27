-- Source config
vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "Source current file" })
vim.keymap.set("n", "<leader>x", "<cmd>.lua<CR>", { desc = "Source current line" })
vim.keymap.set("v", "<leader>x", "<cmd>.lua<CR>", { desc = "Source current highlight" })

-- Clean highlight
vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<CR>", { desc = "Clear highlight" })

-- File save
vim.keymap.set("n", "<leader>fs", "<cmd>w<CR>", { desc = "[F]ile [S]ave" })

-- Center search results
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "#", "#zz")
vim.keymap.set("n", "*", "ma*`a")
vim.keymap.set("n", "g*", "g*zz")

-- Add undo breakpoints at punctuations
vim.keymap.set("i", ",", ",<C-g>u")
vim.keymap.set("i", ".", ".<C-g>u")
vim.keymap.set("i", "!", "!<C-g>u")
vim.keymap.set("i", "?", "?<C-g>u")
vim.keymap.set("i", ";", ";<C-g>u")
vim.keymap.set("i", ":", ":<C-g>u")

-- Don't copy replaced text after pasting in visual mode
vim.keymap.set("v", "p", '"_dP')

-- Keep cursor position after yank
vim.keymap.set("v", "y", "ygv<Esc>")

-- Quick append to the end of line
vim.keymap.set("n", "<leader>,", "maA,<Esc>`a")
vim.keymap.set("n", "<leader>;", "maA;<Esc>`a")
vim.keymap.set("n", "<leader>:", "maA:<Esc>`a")

-- Move by visual line
vim.keymap.set("n", "j", '(v:count > 5 ? "m\'" . v:count : "") . "gj"', { expr = true })
vim.keymap.set("n", "k", '(v:count > 5 ? "m\'" . v:count : "") . "gk"', { expr = true })
vim.keymap.set("v", "j", '(v:count > 5 ? "m\'" . v:count : "") . "gj"', { expr = true })
vim.keymap.set("v", "k", '(v:count > 5 ? "m\'" . v:count : "") . "gk"', { expr = true })
