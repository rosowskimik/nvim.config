return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      dim = {
        animate = { enabled = false },
      },
      gitbrowse = {
        url_patterns = {
          ["codeberg%.org"] = {
            branch = "/src/branch/{branch}",
            file = "/src/branch/{branch}/{file}#L{line_start}-L{line_end}",
            permalink = "/src/branch/{commit}/{file}#L{line_start}-L{line_end}",
            commit = "/commit/{commit}",
          },
        },
      },
      indent = {
        enabled = true,
        animate = { enabled = false },
      },
      lazygit = {
        configure = false,
      },
      picker = {
        matcher = {
          frecency = true,
        },
        formatters = {
          file = {
            filename_first = true,
          },
        },
        sources = {
          files = { layout = "ivy" },
          grep = { layout = "ivy" },
          buffers = { layout = "ivy" },
          todo_comments = { layout = "ivy" },
          lsp_definitions = { layout = "ivy" },
          lsp_references = { layout = "ivy" },
          lsp_implementations = { layout = "ivy" },
          lsp_type_definitions = { layout = "ivy" },
          keymaps = { layout = "dropdown" },
          lines = { layout = "dropdown" },
        },
      },
      notifier = { enabled = true, timeout = 3000, style = "compact" },
      quickfile = { enabled = true },
      rename = { enabled = true },
      scratch = {
        win = { border = "single" },
      },
    },
    init = function()
      vim.api.nvim_set_hl(0, "SnacksIndent", { fg = "#29394f" })
      vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = "#4d6380" })
    end,
    keys = {
      -- bufdelete
      {
        "<leader>q",
        function()
          local bufs = vim.fn.getbufinfo({ buflisted = 1 })
          if #bufs == 1 then
            vim.cmd("confirm qa")
          else
            Snacks.bufdelete()
          end
        end,
        { desc = "Close buffer" },
      },
      -- dim
      {
        "<leader>td",
        function()
          if Snacks.dim.enabled then
            Snacks.dim.disable()
          else
            Snacks.dim.enable()
          end
        end,
      },
      -- gitbrowse
      {
        "<leader>gB",
        function()
          Snacks.gitbrowse()
        end,
        desc = "Git browse",
        mode = { "n", "v" },
      },
      -- lazygit
      {
        "<leader>gg",
        function()
          Snacks.lazygit()
        end,
        { desc = "Toggle lazygit" },
      },
      -- Notifier
      {
        "<leader>un",
        function()
          Snacks.notifier.hide()
        end,
        desc = "Dismiss notifications",
      },
      {
        "<leader>nh",
        function()
          Snacks.notifier.show_history()
        end,
        desc = "Notification history",
      },
      -- picker
      {
        "<leader>sf",
        function()
          Snacks.picker.files()
        end,
        desc = "Find files",
      },
      {
        "<leader>sr",
        function()
          Snacks.picker.recent()
        end,
        desc = "Recent files",
      },
      {
        "<leader>sn",
        function()
          Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
        end,
        desc = "Neovim config files",
      },
      {
        "<leader>sg",
        function()
          Snacks.picker.grep()
        end,
        desc = "Grep",
      },
      {
        "<leader>sb",
        function()
          Snacks.picker.lines()
        end,
        desc = "Search buffer",
      },
      {
        "<leader>sw",
        function()
          Snacks.picker.grep_word()
        end,
        desc = "Grep word under cursor",
        mode = { "n", "v" },
      },
      {
        "<leader>sk",
        function()
          Snacks.picker.keymaps()
        end,
        desc = "Keymaps",
      },
      {
        "<leader>sc",
        function()
          Snacks.picker.commands()
        end,
        desc = "Commands",
      },
      {
        "<leader>sh",
        function()
          Snacks.picker.help()
        end,
        desc = "Help pages",
      },
      {
        "<leader>sd",
        function()
          Snacks.picker.diagnostics()
        end,
        desc = "Diagnostics",
      },
      {
        "<leader>su",
        function()
          Snacks.picker.undo()
        end,
        desc = "Undo history",
      },
      {
        "<leader>gl",
        function()
          Snacks.picker.git_log()
        end,
        desc = "Git log",
      },
      {
        "<leader>s.",
        function()
          Snacks.picker.resume()
        end,
        desc = "Resume last picker",
      },
      -- Scratch
      {
        "<leader>os",
        function()
          Snacks.scratch()
        end,
        desc = "Scratch buffer",
      },
      {
        "<leader>oS",
        function()
          Snacks.scratch.select()
        end,
        desc = "Select scratch buffer",
      },
    },
  },
}
