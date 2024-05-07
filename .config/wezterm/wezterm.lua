local wezterm = require("wezterm")
local kanagawa_wave = require("kanagawa-wave")
local kanagawa_lotus = require("kanagawa-lotus")
local rose_pine = require("themes.rose-pine")
local rose_pine_dawn = require("themes.rose-pine-dawn")
local rose_pine_moon = require("themes.rose-pine-moon")

local mykeys = {
	{ key = "-", mods = "LEADER", action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
	{
		key = "\\",
		mods = "LEADER",
		action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
	},
	{ key = "z", mods = "LEADER", action = "TogglePaneZoomState" },
	{ key = "c", mods = "LEADER", action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },
	{ key = "Tab", mods = "CTRL", action = wezterm.action({ ActivateTabRelative = 1 }) },
	{ key = "Tab", mods = "SHIFT|CTRL", action = wezterm.action({ ActivateTabRelative = -1 }) },
	{ key = "n", mods = "LEADER", action = wezterm.action({ ActivateTabRelative = 1 }) },
	{ key = "p", mods = "LEADER", action = wezterm.action({ ActivateTabRelative = -1 }) },
}

for i = 1, 8 do
	table.insert(mykeys, {
		key = tostring(i),
		mods = "LEADER",
		action = wezterm.action({ ActivateTab = i - 1 }),
	})
end

local function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return "Dark"
end

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Rose Pine"
	else
		return "Rose Pine Dawn"
	end
end

return {
	font = wezterm.font_with_fallback({
		"Iosevka Slab",
		"Symbols Nerd Font",
	}),
	font_size = 18.0,
	force_reverse_video_cursor = true,
	debug_key_events = true,
	color_schemes = {
		["Kanagawa Dark"] = kanagawa_wave,
		["Kanagawa Light"] = kanagawa_lotus,
		["Rose Pine"] = rose_pine.colors(),
		["Rose Pine Dawn"] = rose_pine_dawn.colors(),
		["Rose Pine Moon"] = rose_pine_moon.colors(),
	},
	color_scheme = scheme_for_appearance(get_appearance()),
	-- colors = colors,
	-- color_scheme = "Tokyo Night Storm",
	window_decorations = "RESIZE",
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	audible_bell = "Disabled",
	-- Tab bar
	enable_tab_bar = true,
	use_fancy_tab_bar = false,
	tab_max_width = 64,
	hide_tab_bar_if_only_one_tab = true,
	tab_bar_at_bottom = true,
	use_resize_increments = false,
	-- Keyboard mapping
	leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 },
	keys = mykeys,
	window_background_opacity = 1,
	macos_window_background_blur = 30,
}
