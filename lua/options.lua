local g = vim.g
local cmd = vim.cmd
local o = vim.opt

o.timeoutlen = 300
o.encoding = "utf-8"
o.fileformat = "unix"
o.scrolloff = 6
o.showtabline = 2
o.showmode = false
o.hidden = true
o.wrap = true
o.joinspaces = false
o.lazyredraw = true
o.clipboard = "unnamedplus"
o.splitright = true
o.splitbelow = true
o.number = true
o.relativenumber = true
o.signcolumn = "yes"
o.foldlevelstart = 99
o.foldmethod = "indent"
o.synmaxcol = 500
o.laststatus = 3
o.diffopt:append("iwhite")
o.diffopt:append("algorithm:patience")
o.diffopt:append("indent-heuristic")
o.diffopt:append("vertical")
o.showcmd = true
o.mouse = "a"
o.shortmess:append("c")
o.cursorline = true
o.incsearch = true
o.ignorecase = true
o.smartcase = true
o.gdefault = true
o.inccommand = "nosplit"
o.switchbuf = "useopen"
o.compatible = false
o.breakindent = true
o.belloff = "all"

o.formatoptions = o.formatoptions - "a" - "t" + "c" + "q" - "o" + "r" + "n" + "j" - "2"

-- o.listchars = { eol = "↲", tab = "» ", trail = "·", extends = "<", precedes = ">", conceal = "┊", nbsp = "␣" }
-- o.list = true

-- Tab
o.expandtab = true
o.tabstop = 4
o.expandtab = true
o.smartindent = true

-- Completion
o.cmdheight = 2
o.updatetime = 300
o.completeopt = { "menu", "menuone" }

-- Permanent undo
o.swapfile = false
o.backup = false
o.undodir = vim.fn.stdpath("data") .. "/vimdid"
o.undofile = true
o.undolevels = 1000

-- Wildmenu
o.wildmenu = true
o.wildignore = {
  ".hg",
  ".svn",
  "*~",
  "*.png",
  "*.jpg",
  "*.gif",
  "*.settings",
  "Thumbs.db",
  "*.min.js",
  "*.swp",
  "publish/*",
  "intermediate/*",
  "*.o",
  "*.hi",
  "Zend",
  "vendor",
}
o.pumblend = 17
o.wildoptions = "pum"
