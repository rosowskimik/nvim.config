local state = {
  floating = {
    buf = -1,
    win = -1,
  },
}

local function create_floating_window(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  local buf = -1
  if vim.api.nvim_buf_is_valid(state.floating.buf) then
    buf = state.floating.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end

  local win_config = {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal",
    border = "single",
  }

  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

local function toggle_lazygit()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = create_floating_window({ buf = state.floating.buf })
    if vim.bo[state.floating.buf].buftype ~= "terminal" then
      vim.fn.termopen("lazygit")
    end
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
  vim.cmd("normal i")

  -- Set local keymaps
  vim.keymap.set("t", "`", toggle_lazygit, { buffer = state.floating.buf, desc = "Close Lazygit Window" })
end

vim.keymap.set("n", "<leader>g", toggle_lazygit, { desc = "Open Lazygit Window" })
vim.keymap.set("n", "`", toggle_lazygit, { desc = "Toggle Lazygit Window" })
