local lspkind = require("lspkind")
local luasnip = require("luasnip")
local autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")

cmp.event:on("confirm_done", autopairs.on_confirm_done({ map_char = { tex = "" } }))

cmp.setup({
  completion = {
    completeopt = "menuone,noinsert",
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    -- ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item({ cmp.SelectBehavior.Select }), { "i", "c" }),
    ["<C-j>"] = cmp.mapping(function(fallback)
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      elseif cmp.visible() then
        cmp.select_next_item({ cmp.SelectBehavior.Select })
      else
        fallback()
      end
    end, { "i", "s" }),
    -- ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item({ cmp.SelectBehavior.Select }), { "i", "c" }),
    ["<C-k>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      elseif cmp.visible() then
        cmp.select_prev_item({ cmp.SelectBehavior.Select })
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<M-j>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<M-k>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<enter>"] = cmp.mapping(cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }, { "i", "c" })),
  },
  sources = {
    { name = "nvim_lua" },
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "luasnip" },
    { name = "buffer", keyword_length = 5 },
  },
  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,

      function(entry1, entry2)
        local _, entry1_under = entry1.completion_item.label:find("^_+")
        local _, entry2_under = entry2.completion_item.label:find("^_+")
        entry1_under = entry1_under or 0
        entry2_under = entry2_under or 0
        if entry1_under > entry2_under then
          return false
        elseif entry1_under < entry2_under then
          return true
        end
      end,

      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
  formatting = {
    format = lspkind.cmp_format({
      with_text = true,
      menu = {
        buffer = "[buf]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[api]",
        path = "[path]",
        luasnip = "[snip]",
      },
      maxwidth = 50,
    }),
  },
  experimental = {
    native_menu = false,
    ghost_text = true,
  },
})
