local persist_path = "/tmp/nvim_format_disabled.json"

local function load_disabled()
  local f = io.open(persist_path, "r")
  if not f then
    return {}
  end
  local ok, data = pcall(vim.json.decode, f:read("*a"))
  f:close()
  return ok and data or {}
end

local function save_disabled(tbl)
  local f = io.open(persist_path, "w")
  if not f then
    return
  end
  f:write(vim.json.encode(tbl))
  f:close()
end

return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
      notify_on_error = false,
      default_format_opts = {
        lsp_format = "fallback",
      },
      formatters_by_ft = {
        bash = { "shfmt", "shellcheck" },
        bzl = { "buildifier" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        go = { "goimports", "gofmt" },
        gn = { "gn" },
        javascript = { "deno_fmt" },
        json = { "deno_fmt" },
        lua = { "stylua" },
        latex = { "latexindent" },
        proto = { "buf" },
        python = { "ruff_organize_imports", "ruff_format" },
        systemverilog = { "verible" },
        markdown = { "mdformat", "injected" },
        nix = { "nixfmt" },
        rust = { "rustfmt" },
        sh = { "shfmt", "shellcheck" },
        toml = { "taplo" },
        typescript = { "deno_fmt" },
        typst = { "typstyle" },
        verilog = { "verible" },
        zig = { "zigfmt" },
        zsh = { "shfmt", "shellcheck" },
      },
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2", "-s" },
        },
      },
    },
    config = function(_, opts)
      local conform = require("conform")

      vim.api.nvim_create_autocmd("BufReadPost", {
        desc = "Restore per-file format-on-save state",
        group = vim.api.nvim_create_augroup("user-conform-persist", { clear = true }),
        callback = function(ev)
          local name = vim.api.nvim_buf_get_name(ev.buf)
          if name == "" then
            return
          end
          if load_disabled()[name] then
            vim.b[ev.buf].disable_autoformat = true
          end
        end,
      })

      local slow_fts = {}

      opts.format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        if slow_fts[vim.bo[bufnr].filetype] then
          return
        end
        return { timeout_ms = 500, lsp_format = "fallback" }, function(err)
          if err and err:match("timeout$") then
            slow_fts[vim.bo[bufnr].filetype] = true
          end
        end
      end

      opts.format_after_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        if not slow_fts[vim.bo[bufnr].filetype] then
          return
        end
        return { lsp_format = "fallback" }
      end

      conform.setup(opts)
    end,
    keys = {
      {
        "<leader>ff",
        function()
          require("conform").format({ lsp_format = "fallback", async = true })
        end,
        mode = "n",
        desc = "Format buffer",
      },
      {
        "<leader>ff",
        function()
          require("conform").format({
            lsp_format = "fallback",
            async = true,
          })
        end,
        mode = "v",
        desc = "Format selection",
      },
      {
        "<leader>tf",
        function()
          local bufnr = vim.api.nvim_get_current_buf()
          local name = vim.api.nvim_buf_get_name(bufnr)
          local new_state = not vim.b[bufnr].disable_autoformat
          vim.b[bufnr].disable_autoformat = new_state

          if name ~= "" then
            local disabled = load_disabled()
            if new_state then
              disabled[name] = true
            else
              disabled[name] = nil
            end
            save_disabled(disabled)
          end

          vim.notify(
            "Format-on-save " .. (new_state and "disabled" or "enabled"),
            vim.log.levels.INFO,
            { title = "conform.nvim" }
          )
        end,
        desc = "Toggle format-on-save",
      },
    },
  },
}
