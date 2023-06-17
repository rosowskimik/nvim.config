local g = vim.g

g.tmux_navigator_no_mappings = 1

K("n", "M-H", ":<C-U>TmuxNavigateLeft<CR>")
K("n", "M-J", ":<C-U>TmuxNavigateDown<CR>")
K("n", "M-K", ":<C-U>TmuxNavigateUp<CR>")
K("n", "M-L", ":<C-U>TmuxNavigateDown<CR>")
