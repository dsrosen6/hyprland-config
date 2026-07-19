require("hyprland.modules.monitor").new({
	lid_state_path = "/proc/acpi/button/lid/LID/state",
	switch_name = "Lid Switch",

	laptop = {
		output = "eDP-1",
		mode = "1920x1200",
		scale = "1.25",
	},

	external = {
		output = "DP-1",
		mode = "3440x1440@174.96",
		scale = "1.0",
	},
})
