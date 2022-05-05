local utils = require("utils")
local telescope = require("telescope")
local actions = require("telescope.actions")
local sorters = require("telescope.sorters")
local builtin = require("telescope.builtin")

telescope.setup({
  defaults = {
    file_sorter = sorters.get_fzy_sorter,
    prompt_prefix = " >",
    color_devicons = true,

    mappings = {
      i = {
        ["<C-x>"] = false,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<M-j>"] = actions.move_selection_next,
        ["<M-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.send_to_qflist,
        ["<C-_>"] = actions.close,
      },
      n = {
        ["<C-q>"] = actions.send_to_qflist,
        ["q"] = actions.close,
        ["<C-_>"] = actions.close,
      },
    },
    -- pickers = {
    -- 	file_browser = {
    -- 		hidden = true,
    -- 	},
    -- },
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    },
  },
})

telescope.load_extension("harpoon")

M.search_nvim_config = function()
  builtin.find_files({
    prompt_title = "< VimRC >",
    cwd = utils.nvim_config_path(),
    hidden = true,
  })
end

K("n", "<leader>gb", ":Telescope git_branches<CR>")
K("n", "<leader>gg", ":Telescope git_status<CR>")
-- K("n", "<leader>ff", ":Telescope find_files<CR>")
K("n", "<leader>fe", ":Telescope file_browser<CR>")
vim.keymap.set("n", "<leader>fe", function()
  builtin.find_files({ hidden = true })
end)
K("n", "<leader>fb", ":Telescope buffers<CR>")
K("n", "<leader>fh", ":Telescope help_tags<CR>")
K("n", "<leader>fo", ":Telescope oldfiles<CR>")
K("n", "gr", ":Telescope lsp_references<CR>")
K("n", "gI", ":Telescope lsp_implementations<CR>")
K("n", "gs", ":Telescope lsp_document_symbols<CR>")
K("n", "gws", ":Telescope lsp_dynamic_workspace_symbols<CR>")
K("n", "<leader>fd", ":lua M.search_nvim_config()<CR>")
K("n", "<leader>fw", ':lua require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") })<CR>')
K("n", "<leader>fg", ':lua require("telescope.builtin").grep_string({ search = vim.fn.input("Grep for > ") })<CR>')
