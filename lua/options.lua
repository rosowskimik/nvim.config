-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: For more options, you can see `:help option-list`

-- Relative line numbers with current absolute
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse
vim.opt.mouse = 'a'

-- Don't show mode, shown in statusline
vim.opt.showmode = false

-- Use system clipboard
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Persistent undo
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

-- Case-insensitive search unless capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Highlight search matches when typing
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Decrease wait time for a mapped sequence
vim.opt.timeoutlen = 500

-- Split config
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Signal whitespace in editor
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitution
vim.opt.inccommand = 'split'

-- Set 'g' flag by default in substitution
vim.opt.gdefault = true

-- Highlight line with cursor
vim.opt.cursorline = true

-- Minimal number of screen lines to keep between cursor and screen edges
vim.opt.scrolloff = 10

-- Force use of utf8
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

-- Always show tabline
vim.opt.showtabline = 1

-- Stop syntax highlight in long, single line files
vim.opt.synmaxcol = 1000

-- Setup diff mode options
vim.opt.diffopt:append { 'iwhite', 'algorithm:patience', 'indent-heuristic', 'vertical' }

-- Controls the behavior when switching between buffers
vim.opt.switchbuf = 'usetab'

-- Setup Tab
vim.opt.expandtab = false
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4

-- Autoindent
vim.opt.smartindent = true

-- Completion options
vim.opt.completeopt = { 'menu', 'menuone' }

-- Show wildmenu completions in semi-transparent popup
vim.opt.wildoptions = 'pum'
vim.opt.pumblend = 17
