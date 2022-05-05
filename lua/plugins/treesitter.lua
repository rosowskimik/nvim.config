require("nvim-treesitter.configs").setup({
	ensure_installed = "all",
	highlight = { enable = true },
	context_commentstring = { enable = true },
	matchup = { enable = true },
	rainbow = { enable = true, extended_mode = true },
	autotag = { enable = true },
})
