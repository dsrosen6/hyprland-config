local M = {}

local function hex_to_rgb(hex)
	hex = hex:gsub("#", "")
	return tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5, 6), 16)
end

local function rgb_to_hex(r, g, b) return string.format("#%02x%02x%02x", math.floor(r + 0.5), math.floor(g + 0.5), math.floor(b + 0.5)) end

function M.mute(hex, amount)
	amount = amount or 0.3
	local r, g, b = hex_to_rgb(hex)
	local gray = 0.299 * r + 0.587 * g + 0.114 * b

	r = r + (gray - r) * amount
	g = g + (gray - g) * amount
	b = b + (gray - b) * amount

	return rgb_to_hex(r, g, b)
end

function M.transparent(hex, alpha)
	alpha = alpha or 0.8
	hex = hex:gsub("#", "")
	local a = math.floor(alpha * 255 + 0.5)
	return string.format("#%s%02x", hex, a)
end

function M.rgb_string(color) return string.format("rgb(%s)", color) end
return M
