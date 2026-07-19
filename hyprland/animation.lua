local am = require("hyprland.modules.animation")
local window_popin_pct = 70
local ws_slide_pct = 30

local function popin_pct(pct) return "popin " .. pct .. "%" end

local function slidefd_pct(pct) return "slidefade " .. pct .. "%" end

hl.config({ animations = { enabled = true } })

am.define_beziers({
	{ name = "easeInCubic", points = { { 0.32, 0 }, { 0.67, 0 } } },
	{ name = "easeOutCubic", points = { { 0.33, 1 }, { 0.68, 1 } } },
	{ name = "easeInOutCubic", points = { { 0.65, 0 }, { 0.35, 1 } } },
	{ name = "linear", points = { { 0, 0 }, { 1, 1 } } },
	{ name = "almostLinear", points = { { 0.5, 0.5 }, { 0.75, 1 } } },
})

am.define_animations({
	{ leaf = "global", enabled = true, curve = "default", speed = 10 },
	{ leaf = "fade", enabled = true, curve = "almostLinear", speed = 3.03 },

	{ leaf = "windows", enabled = true, curve = "easeOutCubic", speed = 3, style = popin_pct(window_popin_pct) },
	{ leaf = "fadeIn", enabled = true, curve = "almostLinear", speed = 2 },
	{ leaf = "fadeOut", enabled = true, curve = "almostLinear", speed = 2 },

	{ leaf = "layers", enabled = true, curve = "easeOutCubic", speed = 1, style = "fade" },
	{ leaf = "layersIn", enabled = true, curve = "easeOutCubic", speed = 1, style = "fade" },
	{ leaf = "layersOut", enabled = true, curve = "easeOutCubic", speed = 1, style = "fade" },
	{ leaf = "fadeLayersIn", enabled = true, curve = "almostLinear", speed = 1.79 },
	{ leaf = "fadeLayersOut", enabled = true, curve = "almostLinear", speed = 1.39 },

	{ leaf = "workspaces", enabled = true, curve = "easeInOutCubic", speed = 2.5, style = slidefd_pct(ws_slide_pct) },
	{ leaf = "specialWorkspace", enabled = true, curve = "easeInOutCubic", speed = 2, style = "fade" },

	{ leaf = "border", enabled = true, curve = "easeOutCubic", speed = 5.39 },
	{ leaf = "zoomFactor", enabled = true, curve = "almostLinear", speed = 7 },
})
