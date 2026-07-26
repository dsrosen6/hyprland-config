local noctalia = require("hyprland.modules.noctalia")
local lo = require("hyprland.modules.layout")
local focus = require("hyprland.modules.focus").focus
local bind_dwindle = lo.bind_dwindle
local bind_scrolling = lo.bind_scrolling
local cycle_layout = lo.cycle_layout

local knobD = "XF86AudioLowerVolume"
local knobU = "XF86AudioRaiseVolume"
local function uwsm(app) return "uwsm-app -- " .. app end
local function open_in_term(cmd) return "uwsm-app -- ghostty -e " .. cmd end

-- SYSTEM
hl.bind("SUPER + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind("CTRL + ALT + L", hl.dsp.exec_cmd("loginctl lock-session"))
hl.bind("SUPER + SHIFT + N", noctalia.toggle_shell())

-- MOUSE BINDS --
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e+1" }))

-- APPS --
local terminal = uwsm("ghostty")
local files = uwsm("nautilus")
local default_browser = uwsm("firefox")
local alt_browser = uwsm("google-chrome-stable")

hl.bind("SUPER + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + B", hl.dsp.exec_cmd(default_browser))
hl.bind("SUPER + SHIFT + B", hl.dsp.exec_cmd(alt_browser))
hl.bind("SUPER + E", hl.dsp.exec_cmd(files))
hl.bind("SUPER + Y", hl.dsp.exec_cmd(open_in_term("yazi")))
hl.bind("SUPER + A", hl.dsp.exec_cmd("claude-desktop"))
hl.bind("SUPER + N", hl.dsp.exec_cmd(uwsm("notion-app")))
hl.bind("CTRL + SHIFT + SPACE", hl.dsp.exec_cmd("1password --quick-access")) -- hyprctl reload to fix if not working

-- UTILITIES --
hl.bind("SUPER + COMMA", noctalia.settings())
hl.bind("SUPER + SHIFT + COMMA", hl.dsp.exec_cmd(open_in_term("nvim ~/.config/hypr/hyprland/binds.lua")))
hl.bind("SUPER + P", noctalia.bar_toggle())
hl.bind("SUPER + D", noctalia.dock_toggle())
hl.bind("CTRL + SHIFT + 3", noctalia.screenshot_fullscreen())
hl.bind("CTRL + SHIFT + 4", noctalia.screenshot_region())

-- MENUS / OVERLAYS
hl.bind("CTRL + SPACE", noctalia.launcher())
hl.bind("SUPER + SHIFT + P", noctalia.session_menu())
hl.bind("SUPER + C", noctalia.clipboard())
hl.bind("ALT + TAB", noctalia.window_switcher())

-- TILING / WORKSPACES --
hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + F", hl.dsp.window.fullscreen())

hl.bind("SUPER + H", focus("left"))
hl.bind("SUPER + J", focus("down"))
hl.bind("SUPER + K", focus("up"))
hl.bind("SUPER + L", focus("right"))
hl.bind("SUPER + SHIFT + H", hl.dsp.window.move({ direction = "left", group_aware = true }))
hl.bind("SUPER + SHIFT + J", hl.dsp.window.move({ direction = "down", group_aware = true }))
hl.bind("SUPER + SHIFT + K", hl.dsp.window.move({ direction = "up", group_aware = true }))
hl.bind("SUPER + SHIFT + L", hl.dsp.window.move({ direction = "right", group_aware = true }))
hl.bind("SUPER + MINUS", hl.dsp.window.resize({ x = -30, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + EQUAL", hl.dsp.window.resize({ x = 30, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + " .. knobD, hl.dsp.window.resize({ x = -30, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + " .. knobU, hl.dsp.window.resize({ x = 30, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + SHIFT + MINUS", hl.dsp.window.resize({ x = -100, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + SHIFT + EQUAL", hl.dsp.window.resize({ x = 100, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + CTRL + MINUS", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })
hl.bind("SUPER + CTRL + EQUAL", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })
hl.bind("SUPER + CTRL + " .. knobU, hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })
hl.bind("SUPER + CTRL + " .. knobD, hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })

for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- GROUPBAR --
hl.bind("SUPER + G", hl.dsp.group.toggle())
hl.bind("SUPER + CTRL + G", hl.dsp.group.lock_active())
hl.bind("SUPER + CTRL + H", hl.dsp.group.prev())
hl.bind("SUPER + CTRL + L", hl.dsp.group.next())
hl.bind("SUPER + CTRL + SHIFT + H", hl.dsp.group.move_window({ forward = false }))
hl.bind("SUPER + CTRL + SHIFT + L", hl.dsp.group.move_window({ forward = true }))

-- LAYOUT --
hl.bind("SUPER + SLASH", cycle_layout())
bind_dwindle("SUPER + T", hl.dsp.layout("togglesplit")) -- dwindle only
bind_dwindle("SUPER + X", hl.dsp.layout("swapsplit"))

bind_scrolling("SUPER + SHIFT + MINUS", hl.dsp.layout("colresize -conf"))
bind_scrolling("SUPER + SHIFT + EQUAL", hl.dsp.layout("colresize +conf"))
bind_scrolling("SUPER + M", function() -- cycle between center and fit focus method
	local current_fit = hl.get_config("scrolling.focus_fit_method")
	local new_fit = current_fit == 0 and 1 or 0
	hl.config({ scrolling = { focus_fit_method = new_fit } })
end)

-- SCRATCHPAD --
hl.bind("SUPER + S", hl.dsp.workspace.toggle_special("S"))
hl.bind("SUPER + SHIFT + S", hl.dsp.window.move({ workspace = "special:S" }))

-- MULTIMEDIA KEYS --
hl.bind("XF86MonBrightnessUp", noctalia.brightness_up(), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", noctalia.brightness_down(), { locked = true, repeating = true })
hl.bind("XF86AudioNext", noctalia.media_next(), { locked = true })
hl.bind("XF86AudioPause", noctalia.media_play_pause(), { locked = true })
hl.bind("XF86AudioPlay", noctalia.media_play_pause(), { locked = true })
hl.bind("XF86AudioPrev", noctalia.media_prev())
hl.bind("XF86AudioRaiseVolume", noctalia.volume_up(), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", noctalia.volume_down(), { locked = true, repeating = true })
hl.bind("XF86AudioMute", noctalia.volume_mute(), { locked = true, repeating = true })
