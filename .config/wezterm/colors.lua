local wezterm = require("wezterm")

local M = {}
function M.select(colors, palette)
	return {
		foreground = colors[palette].foreground,
		background = colors[palette].background,
		cursor_bg = colors[palette].cursor_bg,
		cursor_border = colors[palette].cursor_bg,
		cursor_fg = colors[palette].cursor_fg,
		selection_bg = colors[palette].selection_bg,
		selection_fg = colors[palette].selection_fg,
		ansi = colors[palette].ansi,
		brights = colors[palette].brights,
		tab_bar = {
			background = colors[palette].background,
			-- separator = colors[palette].background,
			active_tab = {
				bg_color = colors[palette].brights[3],
				fg_color = colors[palette].background,
			},
			inactive_tab = {
				bg_color = colors[palette].background,
				-- bg_color_odd = colors[palette].background,
				fg_color = colors[palette].foreground,
			},
			inactive_tab_hover = {
				bg_color = colors[palette].selection_bg,
				fg_color = colors[palette].foreground,
			},
			new_tab = {
				bg_color = colors[palette].background,
				fg_color = colors[palette].foreground,
			},
			new_tab_hover = {
				bg_color = colors[palette].selection_fg,
				fg_color = colors[palette].foreground,
				italic = true,
			},
		},
		visual_bell = colors[palette].selection_bg,
		indexed = {
			[16] = colors[palette].brights[4],
			[17] = colors[palette].brights[4],
		},
		scrollbar_thumb = colors[palette].selection_fg,
		split = colors[palette].background,
		-- nightbuild only
		compose_cursor = colors[palette].brights[4],
	}
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
	local title = " " .. tab.active_pane.title .. " "
	local active = palette.tab_bar.active_tab
	local inactive = palette.tab_bar.inactive_tab
	local is_first = tab.tab_index == 0

	if tab.is_active then
		return {
			{ Background = { Color = palette.tab_bar.background } },
			{ Foreground = { Color = inactive.fg_color } },
			{ Text = is_first and "" or " " },
			{ Background = { Color = active.bg_color } },
			{ Foreground = { Color = active.fg_color } },
			{ Attribute = { Intensity = "Bold" } },
			{ Text = title },
			{ Background = { Color = palette.tab_bar.background } },
			{ Foreground = { Color = inactive.fg_color } },
			{ Text = "" },
		}
	end
	if tab.tab_index % 2 == 0 then
		return {
			{ Background = { Color = palette.tab_bar.background } },
			{ Foreground = { Color = inactive.fg_color } },
			{ Text = is_first and "" or " " },
			{ Background = { Color = inactive.bg_color } },
			{ Foreground = { Color = inactive.fg_color } },
			{ Text = title },
			{ Background = { Color = palette.tab_bar.background } },
			{ Foreground = { Color = inactive.fg_color } },
			{ Text = "" },
		}
	else
		return {
			{ Background = { Color = palette.tab_bar.background } },
			{ Foreground = { Color = inactive.fg_color } },
			{ Text = is_first and "" or " " },
			{ Background = { Color = inactive.bg_color_odd } },
			{ Foreground = { Color = inactive.fg_color } },
			{ Text = title },
			{ Background = { Color = palette.tab_bar.background } },
			{ Foreground = { Color = inactive.fg_color } },
			{ Text = "" },
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
