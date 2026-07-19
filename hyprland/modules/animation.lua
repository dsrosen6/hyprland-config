local M = {}

---@class BezierPoint
---@field [1] number
---@field [2] number

---@class BezierDef
---@field name string
---@field points BezierPoint[]

---@class SpringDef
---@field name string
---@field duration number
---@field bounce number

---@class AnimationDef
---@field leaf string
---@field enabled boolean
---@field curve string
---@field speed number
---@field style? string
---@field bezier? string
---@field spring? string

M.CURVES = {
	bezier = "bezier",
	spring = "spring",
}

M.REGISTRY = {}

--- Convert bounce/duration parameters to mass, stiffness, dampening
--- Based on corrected equations from Apple Developer Forum
---@param duration number Perceptual duration in seconds
---@param bounce number Bounce in range [-1, 1] (0 = no bounce, 1 = max bounce)
---@return number mass
---@return number stiffness
---@return number dampening
function M.bounce_to_spring(duration, bounce)
	local mass = 1.0
	local stiffness = (2 * math.pi / duration) ^ 2
	local dampening
	if bounce >= 0 then
		dampening = (1 - bounce) * 4 * math.pi / duration
	else
		dampening = 4 * math.pi / (duration * (1 + bounce))
	end
	return mass, stiffness, dampening
end

---@param defs BezierDef[]
function M.define_beziers(defs)
	for _, def in ipairs(defs) do
		M.REGISTRY[def.name] = "bezier"
		hl.curve(def.name, {
			type = "bezier",
			points = def.points,
		})
	end
end

---@param defs SpringDef[]
function M.define_springs(defs)
	for _, def in ipairs(defs) do
		local mass, stiffness, dampening = M.bounce_to_spring(def.duration, def.bounce)
		M.REGISTRY[def.name] = "spring"
		hl.curve(def.name, {
			type = "spring",
			mass = mass,
			stiffness = stiffness,
			dampening = dampening,
		})
	end
end

---@param defs AnimationDef[]
function M.define_animations(defs)
	for _, def in ipairs(defs) do
		local curve_type = M.REGISTRY[def.curve]
		if curve_type then
			def[curve_type] = def.curve
		else
			def.bezier = def.curve
		end
		hl.animation({
			leaf = def.leaf,
			enabled = def.enabled,
			bezier = def.bezier,
			spring = def.spring,
			speed = def.speed,
			style = def.style or "",
		})
	end
end

return M
