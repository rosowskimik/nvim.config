local lspformat = require("lsp-format")
local lspconfig = require("lspconfig")

lspformat.setup({
  lua = { indent_width = 2, indent_type = "Spaces" },
})

local c_family = function()
  return {
    formatCommand = [[clang-format --assume-filename=${INPUT}]],
    formatStdin = true,
  }
end

local javascript_family = function()
  return {
    formatCommand = [[deno fmt -]],
    formatStdin = true,
  }
end

lspconfig.efm.setup({
  on_attach = lspformat.on_attach,
  init_options = { documentFormatting = true },
  settings = {
    languages = {
      cmake = {
        { formatCommand = [[cmake-format -]], formatStdin = true },
      },
      c = { c_family() },
      cpp = { c_family() },
      go = {
        { formatCommand = [[gofmt]], formatStdin = true },
        { formatCommand = [[goimports]], formatStdin = true },
      },
      javascript = { javascript_family() },
      javascriptreact = { javascript_family() },
      json = { javascript_family() },
      jsonc = { javascript_family() },
      lua = {
        {
          formatCommand = [[stylua --stdin-filepath ${INPUT} ${--indent-width:indent_width} ${--indent-type:indent_type} -]],
          formatStdin = true,
        },
      },
      python = {
        { formatCommand = [[black --quiet -]], formatStdin = true },
        { formatCommand = [[isort --quiet -]], formatStdin = true },
      },
      rust = {
        { formatCommand = [[rustfmt --emit=stdout]], formatStdin = true },
      },
      toml = {
        { formatCommand = "taplo fmt -", formatStdin = true },
      },
      typescript = { javascript_family() },
      typescriptreact = { javascript_family() },
    },
  },
})

vim.cmd([[cabbrev wq execute "Format sync" <bar> wq]])
