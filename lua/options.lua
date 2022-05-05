local g = vim.g
local cmd = vim.cmd
local o = vim.opt

local disabled_builtins = {
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"gzip",
	"zip",
	"zipPlugin",
	"tar",
	"tarPlugin",
	"getscript",
	"getscriptPlugin",
	"vimball",
	"vimballPlugin",
	"2html_plugin",
	"logipat",
	"rrhelper",
	"spellfile_plugin",
	"tutor_mode_plugin",
	"remote_plugins",
	"matchit",
}

for _, plugin in pairs(disabled_builtins) do
	g["loaded_" .. plugin] = 1
end

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
o.shiftwidth = 4
o.softtabstop = 4
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

local utils = require("utils")

if utils.is_windows() then
	vim.cmd([[
		let &shell = has('win32') ? 'pwsh' : 'powershell'
		let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
		let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		set shellquote= shellxquote=
    ]])
end

if utils.is_wsl() then
	vim.cmd([[
  let g:clipboard = {
      \   'name': 'win32yank-wsl',
      \   'copy': {
      \      '+': 'win32yank -i --crlf',
      \      '*': 'win32yank -i --crlf',
      \    },
      \   'paste': {
      \      '+': 'win32yank -o --lf',
      \      '*': 'win32yank -o --lf',
      \   },
      \   'cache_enabled': 0,
      \ }
  ]])
end
