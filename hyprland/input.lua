hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "",
		kb_rules = "",

		accel_profile = "flat",
		follow_mouse = 1,
		sensitivity = 0.6,
	},
})

-- thinkpad t14 touchpad
hl.device({
	name = "elan0676:00-04f3:3195-touchpad",
	accel_profile = "adaptive",
	natural_scroll = true,
	clickfinger_behavior = true,
	sensitivity = 0.2,
	scroll_factor = 0.5,
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})
