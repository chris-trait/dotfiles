local wezterm = require("wezterm")

local M = {}
function M.select(palettes, current)
	local colors = palettes[current]
	return {
		foreground = colors.fg,
		background = colors.bg,
		cursor_bg = colors.fg,
		cursor_border = colors.fg,
		cursor_fg = colors.bg,
		selection_bg = colors.grey[1],
		selection_fg = colors.fg,
		ansi = { colors.bg, colors.red.base, colors.green.base, colors.yellow.base, colors.blue.base, colors.magenta.base,
			colors.cyan.base, colors.fg },
		brights = { colors.bg, colors.red.bright, colors.green.bright, colors.yellow.bright, colors.blue.bright,
			colors.magenta.bright, colors.cyan.bright, colors.fg },
		-- ansi = { "#1C1917", "#DE6E7C", "#819B69", "#B77E64", "#6099C0", "#B279A7", "#66A5AD", "#B4BDC3" },
		-- brights = { "#403833", "#E8838F", "#8BAE68", "#D68C67", "#61ABDA", "#CF86C1", "#65B8C1", "#888F94" },
		tab_bar = {
			background = colors.bg,
			active_tab = {
				fg_color = colors.beige[9],
				bg_color = colors.beige[5],
			},
			inactive_tab = {
				bg_color = colors.beige[2],
				fg_color = colors.beige[9],
			},
			inactive_tab_hover = {
				bg_color = colors.beige[4],
				fg_color = colors.beige[9],
			},
			new_tab = {
				bg_color = colors.bg,
				fg_color = colors.fg,
			},
			new_tab_hover = {
				bg_color = colors.grey[1],
				fg_color = colors.fg,
				italic = true,
			},
		},
		visual_bell = colors.grey[1],
		indexed = {
			[16] = colors.yellow.bright,
			[17] = colors.yellow.bright,
		},
		scrollbar_thumb = colors.grey[1],
		split = colors.bg,
		-- nightbuild only
		compose_cursor = colors.yellow.bright,
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
