---The layers module allows to define a set of actions that will be executed one after another
-- These "layers" can be then replaced at some other point.
-- The main idea behind this is to be able to replace configurations with local .nvim.lua files
-- inside projects. The most common use case is to change an LSP server configuration or similar
--
---@usage
--	-- Inside a plugin like plugin/fancy.lua
--	require("layers").set("fancy", function() print("from plugin") end)
--
--	-- Inside a custom .nvim.lua
--	require("layers").replace("fancy", function() print("from .nvim.lua") end)
--
--	-- Apply all layers, probably inside after/plugin
--	require("layers").apply()

---@module 'layers'
local layers = {}

local cache = {}

local set_pattern = "LayersSet"
local replace_pattern = "LayersReplace"
local group = vim.api.nvim_create_augroup("Layers", { clear = true })

---Set a new layer
---@param key string the name of the layer
---@param action fun() the action to execute
function layers.set(key, action)
	vim.api.nvim_create_autocmd("User", {
		group = group,
		pattern = set_pattern,
		callback = function()
			cache[key] = action
		end,
	})
end

---Replace an existing layer
---@param key string the name of the layer
---@param action fun() the action to execute
function layers.replace(key, action)
	vim.api.nvim_create_autocmd("User", {
		group = group,
		pattern = replace_pattern,
		callback = function()
			if not cache[key] then
				vim.notify(
					("the layer '%s' has not been set. Use `.set` to define a new layer"):format(key),
					vim.log.levels.WARN,
					{ title = "Layers" }
				)
				return
			end

			cache[key] = action
		end,
	})
end

---Apply all layers and replacements
function layers.apply()
	vim.api.nvim_exec_autocmds("User", { group = group, pattern = set_pattern })
	vim.api.nvim_exec_autocmds("User", { group = group, pattern = replace_pattern })

	for _, action in pairs(cache) do
		action()
	end
end

---List all defined layers
function layers.list()
	local list = {}

	for name, _ in pairs(cache) do
		table.insert(list, name)
	end

	return list
end

return layers
