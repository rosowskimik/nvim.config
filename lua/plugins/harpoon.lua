require("harpoon").setup()

K("n", "<leader>m", "<cmd> lua require('harpoon.ui').toggle_quick_menu()<CR>")
K("n", "<leader>mm", "<cmd> lua require('harpoon.mark').add_file()<CR>")
K("n", "<leader>1", "<cmd> lua require('harpoon.ui').nav_file(1)<CR>")
K("n", "<leader>2", "<cmd> lua require('harpoon.ui').nav_file(2)<CR>")
K("n", "<leader>3", "<cmd> lua require('harpoon.ui').nav_file(3)<CR>")
K("n", "<leader>4", "<cmd> lua require('harpoon.ui').nav_file(4)<CR>")
