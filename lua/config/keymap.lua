-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- File save
vim.keymap.set("n", "<leader>fs", "<cmd>w<cr>", { desc = "Save file" })

-- Retab current buffer
vim.keymap.set("n", "<leader>fr", function()
  local expandtab = vim.opt.expandtab:get()
  vim.cmd("retab!")
  vim.notify("Retabbed buffer (" .. (expandtab and "tabs -> spaces" or "spaces -> tabs") .. ")", vim.log.levels.INFO)
end, { desc = "Retab buffer" })

-- Search highlight
vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- Keep search results centered
vim.keymap.set("n", "n", "nzzzv", { desc = "Next result" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev result" })
vim.keymap.set("n", "#", "#zz", { desc = "Search word backward" })
vim.keymap.set("n", "g*", "g*zz", { desc = "Search partial word forward" })

-- Search word under cursor
vim.keymap.set("n", "*", "mz*`z", { desc = "Search word forward" })

-- Undo breakpoints at punctuation
local break_points = { ",", ".", "!", "?", ";", ":" }
for _, char in ipairs(break_points) do
  vim.keymap.set("i", char, char .. "<C-g>u")
end

-- Paste without replacing register
vim.keymap.set("v", "p", '"_dP', { desc = "Paste" })

-- Restore cursor position after yank
vim.keymap.set("v", "y", "ygv<Esc>", { desc = "Yank" })

-- Append to end of line
vim.keymap.set("n", "<leader>a,", "maA,<esc>`a", { desc = "Append ','" })
vim.keymap.set("n", "<leader>a;", "maA;<esc>`a", { desc = "Append ';'" })
