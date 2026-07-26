local tokyonight = require("hyprland.modules.tokyonight")
local color = require("hyprland.modules.color")

local cursor = "Bibata-Modern-Classic 24"
local function transparent(hex) return color.transparent(hex, 0.3) end

local active = tokyonight.blue
local inactive = transparent(active)
local locked_active = tokyonight.green2
local locked_inactive = transparent(tokyonight.green2)
local text = tokyonight.bg_dark

hl.config({
	misc = {
		font_family = "Ubuntu Sans",
	},

	general = {
		gaps_in = 5,
		gaps_out = 10,

		border_size = 3,

		col = {
			active_border = active,
			inactive_border = inactive,
		},

		resize_on_border = false,
		allow_tearing = false,
		layout = "dwindle",
	},

	group = {
		col = {
			border_active = active,
			border_inactive = inactive,

			border_locked_active = locked_active,
			border_locked_inactive = locked_inactive,
		},

		groupbar = {
			rounding = 6,
			blur = true,

			-- indicator_height, indicator_gap, and text_offset give text on indicator instead of above
			indicator_height = 20,
			indicator_gap = -16,
			text_offset = -2,

			font_size = 12,
			font_weight_active = "bold",
			font_weight_inactive = "bold",
			text_color = text,
			text_color_inactive = text,
			text_color_locked_inactive = text,
			text_padding = 15,

			stacked = false,

			col = {
				active = active,
				inactive = inactive,

				locked_active = locked_active,
				locked_inactive = locked_inactive,
			},
		},
	},

	decoration = {
		rounding = 6,

		-- Change transparency of focused and unfocused windows
		active_opacity = 1.0,
		inactive_opacity = 1.0,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = "0xee1a1a1a",
		},

		blur = {
			enabled = true,
			size = 3,
			passes = 2,
			vibrancy = 0.1696,
		},
	},
})

hl.layer_rule({
	name = "noctalia",
	match = {
		namespace = "noctalia-background-.*$",
	},
	ignore_alpha = true,
	blur_popups = true,
})

hl.on("hyprland.start", function() hl.exec_cmd("hyprctl setcursor " .. cursor) end)
