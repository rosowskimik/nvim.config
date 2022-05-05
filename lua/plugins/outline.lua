require("symbols-outline").setup({
	relative_width = false,
	width = 30,
	keymaps = {
		hover_symbol = { "<C-space>", "K" },
		code_actions = { "a", "i" },
	},
	symbols = {
		Key = { icon = "" },
		Struct = { icon = "פּ" },
		Operator = { icon = "" },
		Interface = { icon = "" },
		Property = { icon = "ﰠ" },
		Method = { icon = "" },
		Variable = { icon = "" },
		Event = { icon = "" },
		Class = { icon = "ﴯ" },
		String = { icon = "﫦" },
		Number = { icon = "" },
		Namespace = { icon = "" },
	},
})

K("n", "<leader>o", ":SymbolsOutline<CR>")
