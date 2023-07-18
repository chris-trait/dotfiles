local wezterm = require("wezterm")

local M = {}
function M.select(colors, current)
	return colors[current]
end

-- utility functions for interacting with wezterm API
local function scheme_for_appearance(appearance, options)
	if appearance:find("Dark") then
		return M.select(options.colors, "dark")
	else
		return M.select(options.colors, "light")
	end
end

local function split(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t = {}
	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		table.insert(t, str)
	end
	return t
end

local function basename(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

-- local SOLID_LEFT_ARROW = ""
local SOLID_RIGHT_ARROW = ""

local palette = {}

local function format_tab_title(tab, tabs, panes, config, hover, max_width)
	local title = "   " .. tab.active_pane.title .. "  "
	local active = palette.tab_bar.active_tab
	local inactive = palette.tab_bar.inactive_tab

	if tab.is_active then
		return {
				{ Background = { Color = active.bg_color } },
				{ Foreground = { Color = active.fg_color } },
				{ Attribute = { Intensity = "Bold" } },
				{ Text = title },
		}
	elseif hover then
		return {
				{ Background = { Color = palette.tab_bar.inactive_tab_hover.bg_color } },
				{ Foreground = { Color = palette.tab_bar.inactive_tab_hover.fg_color } },
				{ Text = title },
		}
	else
		return {
				{ Background = { Color = inactive.bg_color } },
				{ Foreground = { Color = inactive.fg_color } },
				{ Text = title },
		}
	end
end

function M.setup(options)
	local should_sync = true
	if options.sync == false then
		should_sync = false
	end

	options = {
			sync = should_sync,
			colors = options.colors,
			mode = options.mode or "dark",
	}

	-- https://wezfurlong.org/wezterm/config/lua/window/get_appearance.html#windowget_appearance
	if options.sync then
		wezterm.on("window-config-reloaded", function(window)
			local overrides = window:get_config_overrides() or {}
			local appearance = window:get_appearance()
			local scheme = scheme_for_appearance(appearance, options)
			palette = scheme
			if overrides.background ~= scheme.background then
				overrides.colors = scheme
				overrides.mode = appearance:find("Dark") and "dark" or "light"
				window:set_config_overrides(overrides)
			end
		end)
	end

	local new_colors = M.select(options.colors, options.mode)
	palette = new_colors
	wezterm.on("format-tab-title", format_tab_title)
	return new_colors
end

return M
