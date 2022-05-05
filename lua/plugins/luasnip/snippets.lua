local ls = require("luasnip")
ls.cleanup()

-- default snippet parser
local ps = ls.parser.parse_snippet

-- snippet node
local sn = ls.snippet_node

-- snippet creator
-- s(<trigger>, <nodes>)
local s = ls.snippet

-- text node
-- t(<text>)
local t = ls.text_node
-- insert node
-- i(<position>, [default_text])
local i = ls.insert_node

-- choice node
-- c(<position>, {...nodes})
local c = ls.choice_node

-- function node
-- f(function(args, snip, ...user_args) -> string, {...arg_indices}, {..user_args})
local f = ls.function_node

-- dynamic node
-- d(<position>, function(args, parent, old_state, ...user_args) -> snippets, {...arg_indices}, {...user_args})
local d = ls.dynamic_node

-- format node
-- fmt(<fmt_string>, {...nodes})
local fmt = require("luasnip.extras.fmt").fmt

-- repeats node
-- rep(<position>)
local rep = require("luasnip.extras").rep

-- SNIPPETS:

-- ALL:
ls.add_snippets("all", {
  -- Current year
  s(
    "curyear",
    f(function()
      return os.date("%Y")
    end)
  ),
})

-- LUA:
ls.add_snippets("lua", {
  -- Local require
  s(
    "req",
    fmt([[local {} = require("{}")]], {
      f(function(args)
        local parts = vim.split(args[1][1], ".", true)
        return parts[#parts] or ""
      end, { 1 }),
      i(1),
    })
  ),
})

-- RUST:
-- Change result type
local get_test_result = function(position)
  return d(position, function()
    local nodes = {}
    table.insert(nodes, t(""))

    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local matches = false
    for _, line in ipairs(lines) do
      if line:match("anyhow::") then
        matches = true
        break
      end
    end
    if matches then
      table.insert(nodes, fmt([[ -> Result<{}>]], { i(1, "()") }))
    else
      table.insert(nodes, fmt([[ -> Result<{}, {}>]], { i(1, "()"), i(2) }))
    end

    return sn(nil, c(1, nodes))
  end, {})
end

ls.add_snippets("rust", {
  -- Test Module
  s(
    "modtest",
    fmt(
      [[
        #[cfg(test)]
        mod test {{
        {}

            {}
        }}
      ]],
      {
        c(1, { t("   use super::*;"), t("") }),
        i(0),
      }
    )
  ),
  -- Test Case
  s(
    "test",
    fmt(
      [[
        #[test]
        fn {}() {} {{
            {}
        }}
      ]],
      {
        i(1, "testname"),
        get_test_result(2),
        i(0),
      }
    )
  ),
})

-- GO:
ls.add_snippets("go", {
  -- func declaration
  s(
    "fn",
    fmt(
      [[func {}{}({}) {}{{
    {}
}}]],
      {
        c(1, {
          t(""),
          fmt([[({}) ]], { i(1) }),
        }),
        i(2, "funcName"),
        i(3),
        i(4),
        i(0),
      }
    )
  ),
})
