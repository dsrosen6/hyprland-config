local tokyonight = require("hyprland.modules.tokyonight")
local cursor = "Bibata-Modern-Classic 24"

hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 10,

		border_size = 3,

		col = {
			active_border = tokyonight.blue,
			inactive_border = tokyonight.bg_highlight,
		},

		resize_on_border = false,
		allow_tearing = false,
		layout = "dwindle",
	},

	decoration = {
		rounding = 14,
		rounding_power = 2,

		-- Change transparency of focused and unfocused windows
		active_opacity = 1.0,
		inactive_opacity = 1.0,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = 0xee1a1a1a,
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
