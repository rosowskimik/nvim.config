local ls = require("luasnip")
local types = require("luasnip.util.types")

require("plugins.luasnip.snippets")

ls.config.setup({
  history = false,
  updateevents = "TextChanged,TextChangedI",
  delete_check_events = "TextChanged",
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "●", "GruvboxOrange" } },
      },
    },
    [types.insertNode] = {
      active = {
        virt_text = { { "●", "GruvboxBlue" } },
      },
    },
  },
})

local utils = require("utils")
local km = vim.keymap

-- K("i", "<c-k>", "<cmd>lua M.luasnip.expand()<CR>")
-- K("s", "<c-k>", "<cmd>lua M.luasnip.expand()<CR>")
-- km.set({ "i", "s" }, "<c-j>", function()
--   if ls.expand_or_jumpable() then
--     ls.expand_or_jump()
--   end
-- end)

-- K("i", "<c-j>", "<cmd>lua M.luasnip.jump_back()<CR>")
-- K("s", "<c-j>", "<cmd>lua M.luasnip.jump_back()<CR>")
-- km.set({ "i", "s" }, "<c-k>", function()
--   if ls.jumpable(-1) then
--     ls.jump(-1)
--   end
-- end, { silent = true })

-- K("i", "<c-l>", "<cmd>lua M.luasnip.choice()<CR>")
km.set({ "i", "s" }, "<c-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

K("n", "<leader>rs", "<cmd>source " .. utils.nvim_config_path() .. "/lua/plugins/luasnip/snippets.lua<CR>")
