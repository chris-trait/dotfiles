local shades = {
	"#282828",
	"#3c3836",
	"#504945",
	"#665c54",
	"#7c6f64",
	"#a89984",
	"#bdae93",
	"#d5c4a1",
	"#ebdbb2",
	"#fbf1c7",
}

local contrast = {
	light = {
		normal = "#fbf1c7",
		hard = "#f9f5d7",
		soft = "#f2e5bc",
	},
	dark = {
		normal = "#282828",
		hard = "#1d2021",
		soft = "#32302f",
	},
}

local palettes = {
	light = {
		bg = shades[10],
		fg = shades[2],
		shades = shades,
		grey = {
			base = "#7c6f64",
			bright = "#928374",
		},
		red = {
			base = "#cc241d",
			bright = "#9d0006",
		},
		green = {
			base = "#98971a",
			bright = "#79740e",
		},
		yellow = {
			base = "#d79921",
			bright = "#b57614",
		},
		blue = {
			base = "#458588",
			bright = "#076678",
		},
		magenta = {
			base = "#b16276",
			bright = "#8f3f71",
		},
		cyan = {
			base = "#689d6a",
			bright = "#427b58",
		},
		orange = {
			base = "#d65d0e",
			bright = "#af3a03",
		},
	},
	dark = {
		bg = shades[1],
		fg = shades[10],
		shades = shades,
		grey = {
			base = "#7c6f64",
			bright = "#928374",
		},
		red = {
			base = "#cc241d",
			bright = "#9d0006",
		},
		green = {
			base = "#98971a",
			bright = "#79740e",
		},
		yellow = {
			base = "#d79921",
			bright = "#b57614",
		},
		blue = {
			base = "#458588",
			bright = "#076678",
		},
		magenta = {
			base = "#b16276",
			bright = "#8f3f71",
		},
		cyan = {
			base = "#689d6a",
			bright = "#427b58",
		},
		orange = {
			base = "#d65d0e",
			bright = "#af3a03",
		},
	},
}

local M = {}
function M.select(current)
	local mode = "soft"
	local colors = palettes[current]
	return {
		foreground = colors.fg,
		background = contrast[current][mode],
		cursor_bg = colors.fg,
		cursor_border = colors.fg,
		cursor_fg = colors.bg,
		selection_bg = colors.shades[3],
		selection_fg = colors.fg,
		ansi = {
			colors.bg,
			colors.red.base,
			colors.green.base,
			colors.yellow.base,
			colors.blue.base,
			colors.magenta.base,
			colors.cyan.base,
			colors.fg,
		},
		brights = {
			colors.bg,
			colors.red.bright,
			colors.green.bright,
			colors.yellow.bright,
			colors.blue.bright,
			colors.magenta.bright,
			colors.cyan.bright,
			colors.fg,
		},
		tab_bar = {
			background = colors.bg,
			active_tab = {
				fg_color = colors.shades[9],
				bg_color = colors.shades[5],
			},
			inactive_tab = {
				bg_color = colors.shades[2],
				fg_color = colors.shades[9],
			},
			inactive_tab_hover = {
				bg_color = colors.shades[4],
				fg_color = colors.shades[9],
			},
			new_tab = {
				bg_color = colors.bg,
				fg_color = colors.fg,
			},
			new_tab_hover = {
				bg_color = colors.grey.bright,
				fg_color = colors.fg,
				italic = true,
			},
		},
		visual_bell = colors.shades[1],
		indexed = {
			[16] = colors.yellow.bright,
			[17] = colors.yellow.bright,
		},
		scrollbar_thumb = colors.grey.base,
		split = colors.bg,
		-- nightbuild only
		compose_cursor = colors.yellow.bright,
	}
end

return M
