local g = vim.g

g.nvim_tree_git_hl = 1
g.nvim_tree_highlight_opened_files = 1
g.nvim_tree_add_trailing = 1
g.nvim_tree_group_empty = 1

require("nvim-tree").setup({
	actions = {
		open_file = {
			quit_on_open = true,
			window_picker = {
				enable = false,
				exclude = {
					filetype = { "notify", "packer", "qf" },
					buftype = { "terminal", "nofile", "help" },
				},
			},
		},
	},
	renderer = {
		indent_markers = {
			enable = true,
		},
	},
})

K("n", "<leader>e", ":NvimTreeToggle<CR>")
