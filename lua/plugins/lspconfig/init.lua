local lspkind = require("lspkind")
lspkind.init()

local lspformat = require("lsp-format")

local lspconfig = require("lspconfig")

-- Setup diagnostics
local handlers = require("plugins.lspconfig.handlers")

local custom_init = function(client)
	client.config.flags = client.config.flags or {}
	client.config.flags.allow_incremental_sync = true
end

local custom_attach = function(client, bufnr)
	require("lsp_signature").on_attach({
		bind = true,
		handler_opts = { border = "rounded" },
	}, bufnr)

	lspformat.on_attach(client)

	vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

	if client.resolved_capabilities.document_highlight then
		vim.cmd([[
    augroup lsp_document_highlight
      autocmd! * <buffer>
      autocmd CursorHold <buffer> silent! lua vim.lsp.buf.document_highlight()
      autocmd CursorHoldI <buffer> silent! lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> silent! lua vim.lsp.buf.clear_references()
      autocmd CursorMovedI <buffer> silent! lua vim.lsp.buf.clear_references()
    augroup END
    ]])
	end
end

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
updated_capabilities = require("cmp_nvim_lsp").update_capabilities(updated_capabilities)

local servers = {
	html = true,
	vimls = true,
	pyright = (1 == vim.fn.executable("pyright")),
	gopls = (1 == vim.fn.executable("gopls")),
	cmake = (1 == vim.fn.executable("cmake-language-server")),

	clangd = {
		cmd = {
			"clangd",
			"--background-index",
			"--suggest-missing-includes",
			"--clang-tidy",
			"--header-insertion=iwyu",
		},
	},

	tsserver = {
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
		},
	},
}

local setup_server = function(server, config)
	if not config then
		return
	end

	if type(config) ~= "table" then
		config = {}
	end

	config = vim.tbl_deep_extend("force", {
		on_init = custom_init,
		on_attach = custom_attach,
		capabilities = updated_capabilities,
		flags = { debounce_text_changes = 50 },
	}, config)

	lspconfig[server].setup(config)
end

for server, config in pairs(servers) do
	setup_server(server, config)
end

local rust_opts = {}
vim.tbl_deep_extend("force", {
	on_init = custom_init,
	on_attach = custom_attach,
	capabilities = updated_capabilities,
	flags = { debounce_text_changes = 50 },
}, rust_opts)

rust_opts.settings = {
	["rust-analyzer"] = {
		-- Enable for WASM
		experimental = { procAttrMacros = true },
		assist = {
			importGranularity = "crate",
			importPrefix = "by_self",
		},
		cargo = {
			loadOutDirsFromCheck = true,
		},
		procMacro = { enable = true },
		checkOnSave = {
			overrideCommand = { "cargo", "clippy" },
		},
	},
}
require("rust-tools").setup({
	tools = {
		runnables = { use_telescope = true },
		hover_with_actions = false,
		inlay_hints = { highlight = "NonText" },
	},
	server = rust_opts,
})

vim.cmd([[
  function! ShowDocs()
    if (index(['vim', 'help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      execute 'lua vim.lsp.buf.hover()'
    endif
  endfunction
]])

K("n", "gd", ":lua vim.lsp.buf.definition()<CR>")
K("n", "gD", ":lua vim.lsp.buf.declaration()<CR>")
K("n", "gT", ":lua vim.lsp.buf.type_definition()<CR>")
K("n", "<leader>rr", ":LspRestart<CR>")
K("n", "<leader>i", ":lua vim.lsp.buf.code_action()<CR>")
K("v", "<leader>i", ":lua vim.lsp.buf.range_code_action()<CR>")
K("n", "K", ":call ShowDocs()<CR>")
K("n", "<F2>", ":lua vim.lsp.buf.rename()<CR>")
K("n", "g[", ":lua vim.diagnostic.goto_prev()<CR>")
K("n", "g]", ":lua vim.diagnostic.goto_next()<CR>")
