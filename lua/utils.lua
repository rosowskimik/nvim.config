local M = {}

M.is_windows = function()
	return vim.fn.has("win32") == 1
end

M.is_unix = function()
	return vim.fn.has("unix") == 1
end

M.is_wsl = function()
	local output = vim.fn.systemlist("uname -r")
	return not not string.find(output[1] or "", "WSL")
end

M.std_config_path = function()
	if M.is_unix then
		return os.getenv("XDG_CONFIG_HOME")
	else
		return os.getenv("LOCALAPPDATA")
	end
end

M.nvim_config_path = function()
	return M.std_config_path() .. "/nvim"
end

M.get_packer = function()
	if vim.fn.input("Download Packer? (y for yes)") ~= "y" then
		return
	end

	local directory = string.format("%s/site/pack/packer/start/", vim.fn.stdpath("data"))
	vim.fn.mkdir(directory, "p")

	local out = vim.fn.system(
		string.format("git clone %s %s", "https://github.com/wbthomason/packer.nvim", directory .. "/packer.nvim")
	)

	print(out)
	print("Downloading packer.nvim")
	print("( You'll need to restart now )")
end

return M
