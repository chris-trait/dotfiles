local wezterm = require("wezterm")

local M = {}
function M.select(colors, palette)
    return {
        foreground = colors[palette].text,
        background = colors[palette].base,
        cursor_bg = colors[palette].rosewater,
        cursor_border = colors[palette].rosewater,
        cursor_fg = colors[palette].mantle,
        selection_bg = colors[palette].subtext1,
        selection_fg = colors[palette].bg0,
        ansi = {
            colors[palette].subtext0,
            colors[palette].red,
            colors[palette].green,
            colors[palette].yellow,
            colors[palette].blue,
            colors[palette].pink,
            colors[palette].teal,
            colors[palette].surface0,
        },
        brights = {
            colors[palette].overlay0,
            colors[palette].red,
            colors[palette].green,
            colors[palette].yellow,
            colors[palette].blue,
            colors[palette].pink,
            colors[palette].teal,
            colors[palette].text,
        },
        tab_bar = {
            background = colors[palette].base,
            separator = colors[palette].overlay0,
            active_tab = {
                bg_color = colors[palette].teal,
                fg_color = colors[palette].base,
            },
            inactive_tab = {
                bg_color = colors[palette].surface0,
                bg_color_odd = colors[palette].crust,
                fg_color = colors[palette].text,
            },
            inactive_tab_hover = {
                bg_color = colors[palette].surface0,
                fg_color = colors[palette].text,
            },
            new_tab = {
                bg_color = colors[palette].base,
                fg_color = colors[palette].text,
            },
            new_tab_hover = {
                bg_color = colors[palette].surface0,
                fg_color = colors[palette].text,
                italic = true,
            },
        },
        visual_bell = colors[palette].bg4,
        indexed = {
            [16] = colors[palette].orange,
            [17] = colors[palette].orange,
        },
        scrollbar_thumb = colors[palette].surface0,
        split = colors[palette].bg0,
        -- nightbuild only
        compose_cursor = colors[palette].yellow,
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

    if tab.is_active then
        return {
            { Background = { Color = active.bg_color } },
            { Foreground = { Color = active.fg_color } },
            { Text = title },
            { Background = { Color = palette.tab_bar.background } },
            { Foreground = { Color = inactive.fg_color } },
            { Text = "" },
        }
    end
    if tab.tab_index % 2 == 0 then
        return {
            { Background = { Color = inactive.bg_color } },
            { Foreground = { Color = inactive.fg_color } },
            { Text = title },
            { Background = { Color = palette.tab_bar.background } },
            { Foreground = { Color = inactive.fg_color } },
            { Text = "" },
        }
    else
        return {
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
