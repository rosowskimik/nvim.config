-- Line numbers: show absolute on current line, relative elsewhere
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse in all modes
vim.opt.mouse = "a"

-- Mode is shown in statusline (lualine)
vim.opt.showmode = false

-- Sync with system clipboard
vim.opt.clipboard = "unnamedplus"

-- Visually indent wrapped lines to match the original indentation
vim.opt.breakindent = true

-- Smooth scrolling for wrapped lines
vim.opt.smoothscroll = true

-- Persistent undo
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

-- Case-insensitive unless query contains an uppercase letter
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Highlight matches while typing; keep them after search
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Always show sign column to avoid layout shifts
vim.opt.signcolumn = "yes"

-- Faster CursorHold events (used by LSP, gitsigns, etc.)
vim.opt.updatetime = 250

-- Shorter key sequence timeout
vim.opt.timeoutlen = 500

-- New splits open to the right and below
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Show invisible characters
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Live preview of :substitute in a split
vim.opt.inccommand = "split"

-- Apply substitutions globally by default
vim.opt.gdefault = true

-- Highlight the cursor line
vim.opt.cursorline = true

-- Keep context lines visible around the cursor
vim.opt.scrolloff = 18

-- Wrap long lines
vim.opt.wrap = true

-- Break wrapped lines on whitespace
vim.opt.linebreak = true

-- File encoding
vim.opt.fileencoding = "utf-8"

-- Limit syntax highlighting in very long single lines (performance)
vim.opt.synmaxcol = 1000

-- Diff options: ignore whitespace, use patience algorithm with indent heuristic
vim.opt.diffopt:append({ "iwhite", "algorithm:patience", "indent-heuristic", "vertical" })

-- When switching buffers, reuse existing tabs/windows if possible
vim.opt.switchbuf = "usetab"

-- Open folds by default
vim.opt.foldlevel = 99
vim.opt.foldenable = false

-- Smarter autoindent based on syntax
vim.opt.smartindent = true

-- True color support
vim.opt.termguicolors = true

-- Show wildmenu completions in a floating popup
vim.opt.wildoptions = "pum"
vim.opt.pumblend = 17

-- Completion
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Spelling
vim.opt.spelllang = "en_us"
vim.opt.spelloptions = "camel"
