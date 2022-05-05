local hop = require("hop")
hop.setup({})

K("n", "<leader>c", ":HopChar1<CR>")
K("n", "<leader>s", ":HopChar2<CR>")
K("n", "<leader>w", ":HopWord<CR>")
K("n", "<leader>l", ":HopLine<CR>")
