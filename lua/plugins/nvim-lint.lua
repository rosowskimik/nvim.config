local lint = require("lint")

local cppcheck_linter = function(language)
	local pattern = [[([^:]*):(%d*):([^:]*): %[([^%]\]*)%] ([^:]*): (.*)]]
	local groups = { "file", "lnum", "col", "code", "severity", "message" }
	local severity_map = {
		["error"] = vim.diagnostic.severity.ERROR,
		["warning"] = vim.diagnostic.severity.WARN,
		["performance"] = vim.diagnostic.severity.WARN,
		["style"] = vim.diagnostic.severity.INFO,
		["information"] = vim.diagnostic.severity.INFO,
	}

	local config = {
		cmd = "cppcheck",
		stdin = false,
		args = {
			"--enable=warning,style,performance,information",
			"--inconclusive",
			"--language=" .. language,
			"--inline-suppr",
			"--quiet",
			"--template={file}:{line}:{column}: [{id}] {severity}: {message}",
		},
		stream = "stderr",
		parser = require("lint.parser").from_pattern(pattern, groups, severity_map, { ["source"] = "cppcheck" }),
	}
	if vim.fn.findfile("compile_commands.json", ".") ~= "" then
		table.insert(config.args, "--project=compile_commands.json")
	end
	if vim.fn.finddir("build") ~= "" then
		table.insert(config.args, "--cppcheck-build-dir=build")
	end

	return config
end

lint.linters.cppcheck_cpp = function()
	return cppcheck_linter("c++")
end
lint.linters.cppcheck_c = function()
	return cppcheck_linter("c")
end

lint.linters_by_ft = {
	cpp = { "cppcheck_cpp" },
	c = { "cppcheck_c" },
	python = { "mypy", "pylint" },
}

K("n", "<leader>ll", "<cmd> lua require('lint').try_lint()<CR>")
