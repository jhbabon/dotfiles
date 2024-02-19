local wezterm = require("wezterm")
local config = {}

-- Font configuration
-- MonoLisa: https://www.monolisa.dev

-- MonoLisa OpenType Features:
-- * calt: Whitespace ligatures
-- * liga: Coding ligatures
-- * zero: Slashed zero
-- * ss01: Normal asterisk
-- * ss02: Script Variant, only available in Italic
-- * ss03: Alt g
-- * ss04: Another alt g
-- * ss05: Alt sharp S (ß)
-- * ss06: Alt at (@)
-- * ss07: Alt curly bracket
-- * ss08: Alt parenthesis
-- * ss09: Alt greather equal (bigger)
-- * ss10: Another alt greather equal (smaller)
-- * ss11: Hexadecimal x (ie: 0xF)
-- * ss12: Thin backslash

-- To enable a feature use: harfbuzz_features = { "featurename" }
-- To disable a feature use: harfbuzz_features = { "featurename=0" }
-- ref: https://wezfurlong.org/wezterm/config/lua/config/font_rules.html
config.font = wezterm.font({
	family = "MonoLisa",
	weight = "Regular",
	style = "Normal",
	harfbuzz_features = { "zero", "ss01", "ss07", "ss08", "ss09", "ss11", "ss12" },
})
config.font_rules = {
	{
		intensity = "Bold",
		italic = false,
		font = wezterm.font({
			family = "MonoLisa",
			weight = "Bold",
			style = "Normal",
			harfbuzz_features = { "zero", "ss01", "ss07", "ss08", "ss09", "ss11", "ss12" },
		}),
	},

	{
		intensity = "Normal",
		italic = true,
		font = wezterm.font({
			family = "MonoLisa",
			weight = "Regular",
			style = "Italic",
			harfbuzz_features = { "zero", "ss01", "ss02", "ss07", "ss08", "ss09", "ss11", "ss12" },
		}),
	},

	{
		intensity = "Bold",
		italic = true,
		font = wezterm.font({
			family = "MonoLisa",
			weight = "Bold",
			style = "Italic",
			harfbuzz_features = { "zero", "ss01", "ss02", "ss07", "ss08", "ss09", "ss11", "ss12" },
		}),
	},
}

config.font_size = 14.0

config.color_scheme = "Papercolor Light (Gogh)"

return config
