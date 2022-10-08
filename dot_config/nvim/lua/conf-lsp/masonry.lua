-- Utils on top of mason
-- @see https://github.com/franciscoj/dotfiles/blob/f3fe51caa2de92e80862e23b365b393d4630ec6e/dot_config/nvim/lua/franciscoj/mason.lua

local reg = require("mason-registry")
local path = require("mason-core.path")

local masonry = {}

-- receives a package name and returns the path to its binary
function masonry.get_path(package_name)
	return path.concat({ vim.fn.stdpath("data"), "mason", "bin", package_name })
end

-- Receives a table of { name = "package", version = "v1.1.1" } and makes sure they are all installed.
-- `version` can be ommited
function masonry.ensure_tools(packages)
	for _, package in ipairs(packages) do
		local p = reg.get_package(package["name"])

		if not p:is_installed() then
			p:install({ version = package["version"] })
		end
	end
end

return masonry
