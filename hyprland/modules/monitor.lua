---@class MonitorSpec
---@field output string
---@field mode string
---@field scale string

---@class MonitorConfig
---@field lid_state_path string
---@field switch_name string
---@field laptop MonitorSpec
---@field external MonitorSpec

---@class MonitorState
---@field open boolean
---@field has_external boolean

---@class MonitorInstance
---@field set_monitors fun()
---@field current_state fun(): MonitorState
---@field handle_monitor_change fun()

---@param config MonitorConfig
---@return MonitorInstance
local function new(config)
	local function lid_open()
		local handle = io.popen("cat " .. config.lid_state_path)
		if not handle then
			return false
		end

		local output = handle:read("*a")
		handle:close()
		return output:find("open") ~= nil
	end

	local function has_external_monitor()
		for _, m in ipairs(hl.get_monitors()) do
			if m.name == config.external.output then
				return true
			end
		end
		return false
	end

	local function correct_laptop_pos(open, has_external)
		if open then
			if has_external then
				return "3440x120"
			else
				return "0x0"
			end
		else
			return "10000x10000"
		end
	end

	local function set_preferred_monitors()
		local preferred_monitor = config.laptop.output
		for _, m in ipairs(hl.get_monitors()) do
			if m.name == config.external.output then
				preferred_monitor = config.external.output
				break
			end
		end

		for i = 1, 5 do
			hl.workspace_rule({
				workspace = tostring(i),
				monitor = preferred_monitor,
				persistent = true,
			})
		end
	end

	local function set_monitors()
		local open = lid_open()
		local has_external = has_external_monitor()
		local laptop_pos = correct_laptop_pos(open, has_external)

		hl.monitor({
			output = config.laptop.output,
			mode = config.laptop.mode,
			scale = config.laptop.scale,
			position = laptop_pos,
		})

		hl.monitor({
			output = config.external.output,
			mode = config.external.mode,
			scale = config.external.scale,
			position = "0x0",
		})

		set_preferred_monitors()
	end

	local function current_state()
		return {
			open = lid_open(),
			has_external = has_external_monitor(),
		}
	end

	local last_state = current_state()

	local function handle_monitor_change()
		local open = lid_open()
		local has_external = has_external_monitor()

		if open == last_state.open and has_external == last_state.has_external then
			return
		end

		local external_changed = has_external ~= last_state.has_external
		last_state.open = open
		last_state.has_external = has_external
		set_monitors()

		if external_changed then
			hl.dispatch(hl.dsp.focus({ workspace = 1 }))
			hl.dispatch(hl.dsp.exec_cmd("systemctl --user restart waybar.service"))
		end
	end

	set_monitors()

	hl.on("monitor.layout_changed", handle_monitor_change)
	hl.bind("switch:on:" .. config.switch_name, set_monitors, { locked = true })
	hl.bind("switch:off:" .. config.switch_name, set_monitors, { locked = true })

	return {
		set_monitors = set_monitors,
		current_state = current_state,
		handle_monitor_change = handle_monitor_change,
	}
end

return { new = new }
