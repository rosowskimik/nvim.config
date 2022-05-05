local utils = require("utils")

local floaterm_new = function()
  local columns = vim.api.nvim_get_option("columns")
  local rows = vim.api.nvim_get_option("lines")

  local width = 0.7
  local height = 0.7
  if columns * width < 120 then
    width = 1.0
  end
  if rows * height < 30 then
    height = 1.0
  end
  vim.cmd(string.format("FloatermNew --width=%f --height=%f", width, height))
end

vim.keymap.set("n", "<M-1>", floaterm_new)
K(
  "n",
  "<leader>g",
  ":FloatermNew --name=lazygit --title=lazygit --width=1.0 --height=1.0 --autoclose=2 lazygit -ucd "
    .. utils.nvim_config_path()
    .. "/lzg<CR>"
)
K("n", "<M-`>", "<cmd> FloatermToggle<CR>")

vim.keymap.set("t", "<M-1>", floaterm_new)
K("t", "<M-`>", "<C-\\><C-n><cmd> FloatermToggle<CR>")
K("t", "<M-k>", "<C-\\><C-n><cmd> FloatermPrev<CR>")
K("t", "<M-j>", "<C-\\><C-n><cmd> FloatermNext<CR>")
