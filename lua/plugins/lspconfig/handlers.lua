-- local handlers = vim.lsp.handlers

local severity = vim.diagnostic.severity
local diagnostic_config = {
  underline = {
    severity = { min = severity.WARN },
  },
  virtual_text = {
    severity = { min = severity.WARN },
  },
  signs = true,
}
vim.diagnostic.config(diagnostic_config)
--
-- handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   require("lsp_extensions.workspace.diagnostic").handler,
--   diagnostic_config
-- )

vim.cmd([[
sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=
sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=
sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=
sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=
]])
