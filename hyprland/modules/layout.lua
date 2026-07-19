local M = {}
local function current_layout()
	local ws = hl.get_active_workspace()
	if not ws then
		return
	end
	return ws.tiled_layout
end

---@param layout string
---@param keys string
---@param dispatcher HL.Dispatcher|function
---@param opts HL.BindOptions?
local function bind_layout(layout, keys, dispatcher, opts)
	hl.bind(keys, function()
		if current_layout() == layout then
			hl.dispatch(dispatcher)
		end
	end, opts)
end

function M.cycle_layout()
	return function()
		local ws = hl.get_active_workspace()
		if not ws then
			return
		end

		local layouts = { "dwindle", "scrolling" }
		local current = ws.tiled_layout
		local next_layout = layouts[1]
		for i, l in ipairs(layouts) do
			if l == current then
				next_layout = layouts[(i % #layouts) + 1]
				break
			end
		end
		hl.workspace_rule({
			workspace = tostring(ws.id),
			layout = next_layout,
		})
	end
end

---@param keys string
---@param dispatcher HL.Dispatcher|function
---@param opts HL.BindOptions?
function M.bind_dwindle(keys, dispatcher, opts) bind_layout("dwindle", keys, dispatcher, opts) end

---@param keys string
---@param dispatcher HL.Dispatcher|function
---@param opts HL.BindOptions?
function M.bind_master(keys, dispatcher, opts) bind_layout("master", keys, dispatcher, opts) end

---@param keys string
---@param dispatcher HL.Dispatcher|function
---@param opts HL.BindOptions?
function M.bind_scrolling(keys, dispatcher, opts) bind_layout("scrolling", keys, dispatcher, opts) end

return M
