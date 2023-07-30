-- Different small tools

local tools = {}

-- Build a description for a keymap.
-- A description has the form: { "label", "explanation" }
-- Example:
--   desc({ "files", "explore files" })
function tools.desc(description)
	return string.format("%s -> %s", unpack(description))
end

return tools
