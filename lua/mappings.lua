local utils = require("utils")

if utils.is_unix() then
  K("c", "w!!", "w !sudo tee % > /dev/null")
  K("c", "rel!!", "execute ':silent w !sudo tee % > /dev/null' | :edit!")
end

if utils.is_windows() then
  K("n", "<leader>wt", "<cmd>execute '! wt --window 0 -d ' . stdpath('config')<CR>")
end

-- Exit insert/terminal mode using alt-q
K("i", "<C-_>", "<ESC>")
K("t", "<C-_>", "<C-\\><C-n>")

-- Quick save
K("n", "<leader>fs", ":w<CR>")
K("i", "<C-s>", "<esc><cmd>w<cr>a")

-- Change current directory to that of the parent of open buffer
K("n", "<leader>cd", ":cd %:p:h<CR>")

-- Make visual yanks place the cursor back where started
K("v", "y", "ygv<Esc>")

-- Center search results
K("n", "n", "nzzzv")
K("n", "N", "Nzzzv")
K("n", "#", "#zz")
K("n", "g*", "g*zz")
K("n", "*", "ma*`a")

-- Undo breakpoints
K("i", ",", ",<c-g>u")
K("i", ".", ".<c-g>u")
K("i", "!", "!<c-g>u")
K("i", "?", "?<c-g>u")

-- Hide highlights
K("v", "<C-h>", ":nohlsearch<CR>")
K("n", "<C-h>", ":nohlsearch<CR>")

-- Move text around
K("v", "<up>", "xkP`[V`]")
K("v", "<down>", "xp`[V`]")
K("v", "K", ":m '<-2<CR>gv=gv")
K("v", "J", ":m '>+1<CR>gv=gv")

-- Don't copy the replaced text after pasting in visual mode
K("v", "p", '"_dP')

-- Quickly insert at end of the line
K("n", "<leader>,", "maA,<esc>`a")
K("n", "<leader>;", "maA;<esc>`a")
K("n", "<leader>?", "maA?<esc>`a")

-- Move by line
K("n", "k", '(v:count > 5 ? "m\'" . v:count : "") . "gk"', { expr = true })
K("n", "j", '(v:count > 5 ? "m\'" . v:count : "") . "gj"', { expr = true })
K("v", "k", '(v:count > 5 ? "m\'" . v:count : "") . "gk"', { expr = true })
K("v", "j", '(v:count > 5 ? "m\'" . v:count : "") . "gj"', { expr = true })

-- Up and down switches buffers, left and right tabs
K("n", "<up>", ":bn<CR>")
K("n", "<down>", ":bp<CR>")
K("n", "<left>", ":tabp<CR>")
K("n", "<right>", ":tabn<CR>")

-- Exit terminal insert mode
K("t", "<C-_>", "<C-\\><C-n>")
