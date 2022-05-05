local comment = require("Comment")
comment.setup({
	toggler = {
		line = "<C-_>",
		block = "<C-\\>",
	},
})

K("v", "<C-_>", ':lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>')
K("v", "<C-\\>", ':lua require("Comment.api").toggle_blockwise_op(vim.fn.visualmode())<CR>')
