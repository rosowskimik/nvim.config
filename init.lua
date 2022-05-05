vim.g.mapleader = " "
require("globals")

pcall(require, "impatient")
pcall(require, "packer_compiled")

if not pcall(require, "packer") then
	require("utils").get_packer()
	return
end

require("options")
require("plugins")
require("mappings")
require("auto")
