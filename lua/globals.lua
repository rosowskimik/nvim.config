P = function(v)
  print(vim.inspect(v))
  return v
end

if pcall(require, "plenary") then
  RELOAD = function(...)
    return require("plenary.reload").reload_module(...)
  end

  R = function(name)
    reload(name)
    return require(name)
  end
end

K = function(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  -- vim.api.nvim_set_keymap(mode, lhs, rhs, options)
  vim.keymap.set(mode, lhs, rhs, options)
end

M = {}
