-- Check if some local binaries are present
return {
	-- Ruby
	rubocop = vim.fn.executable("bin/rubocop") == 1,
	sorbet = vim.fn.executable("bin/srb") == 1,
}
