local M = {}

function M.focus(direction)
	return function()
		local active_window = hl.get_active_window()
		local default_table = { direction = direction }
		if active_window == nil then
			return
		end

		local group = active_window.group
		if group == nil or group.locked then
			hl.dispatch(hl.dsp.focus({ direction = direction }))
			return
		end

		local size = group.size
		local index = group.current_index

		if direction == "down" or direction == "up" then
			hl.dispatch(hl.dsp.focus(default_table))
		elseif direction == "left" and index == 1 then
			hl.dispatch(hl.dsp.focus(default_table))
		elseif direction == "right" and index == size then
			hl.dispatch(hl.dsp.focus(default_table))
		elseif direction == "left" then
			hl.dispatch(hl.dsp.group.prev())
		elseif direction == "right" then
			hl.dispatch(hl.dsp.group.next())
		end
	end
end

return M
