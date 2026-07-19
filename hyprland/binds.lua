local lo = require("hyprland.modules.layout")
local bind_dwindle = lo.bind_dwindle
local bind_scrolling = lo.bind_scrolling
local cycle_layout = lo.cycle_layout

local knobD = "XF86AudioLowerVolume"
local knobU = "XF86AudioRaiseVolume"
local function noct(cmd) return "qs -c noctalia-shell ipc call " .. cmd end
local function uwsm(app) return "uwsm-app -- " .. app end
local function open_in_term(cmd) return "uwsm-app -- ghostty -e " .. cmd end

-- SYSTEM
hl.bind("SUPER + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind("CTRL + ALT + L", hl.dsp.exec_cmd("loginctl lock-session"))
hl.bind("SUPER + SHIFT + N", hl.dsp.exec_cmd("pkill qs || qs -c 'noctalia-shell'"))

-- MOUSE BINDS --
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e+1" }))

-- APPS --
local terminal = uwsm("ghostty")
local files = open_in_term("yazi")
local default_browser = "firefox"
local alt_browser = "google-chrome-stable"

hl.bind("SUPER + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + B", hl.dsp.exec_cmd(uwsm(default_browser)))
hl.bind("SUPER + SHIFT + B", hl.dsp.exec_cmd(uwsm(alt_browser)))
hl.bind("SUPER + E", hl.dsp.exec_cmd(files))
hl.bind("SUPER + A", hl.dsp.exec_cmd("claude-desktop"))
hl.bind("SUPER + N", hl.dsp.exec_cmd(uwsm("notion-app")))
hl.bind("CTRL + SHIFT + SPACE", hl.dsp.exec_cmd("1password --quick-access")) -- hyprctl reload to fix if not working

-- UTILITIES --
hl.bind("SUPER + COMMA", hl.dsp.exec_cmd(noct("settings toggle")))
hl.bind("SUPER + P", hl.dsp.exec_cmd(noct("bar toggle")))
hl.bind("CTRL + SHIFT + 3", hl.dsp.exec_cmd("grim - | swappy -f -")) -- full screenshot
hl.bind("CTRL + SHIFT + 4", hl.dsp.exec_cmd('grim -g "$(slurp)" - | swappy -f -'))

-- MENUS / OVERLAYS
hl.bind("CTRL + SPACE", hl.dsp.exec_cmd(noct("launcher toggle")))
hl.bind("SUPER + SHIFT + P", hl.dsp.exec_cmd(noct("sessionMenu toggle")))
hl.bind("SUPER + C", hl.dsp.exec_cmd(noct("launcher clipboard")))
hl.bind("SUPER + SHIFT + Y", hl.dsp.exec_cmd("swaync-client -t"))

-- TILING / WORKSPACES --
hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + F", hl.dsp.window.fullscreen())
hl.bind("SUPER + H", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + J", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + L", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind("SUPER + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind("SUPER + MINUS", hl.dsp.window.resize({ x = -30, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + EQUAL", hl.dsp.window.resize({ x = 30, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + " .. knobD, hl.dsp.window.resize({ x = -30, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + " .. knobU, hl.dsp.window.resize({ x = 30, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + SHIFT + MINUS", hl.dsp.window.resize({ x = -100, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + SHIFT + EQUAL", hl.dsp.window.resize({ x = 100, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + CONTROL + MINUS", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })
hl.bind("SUPER + CONTROL + EQUAL", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })
hl.bind("SUPER + CONTROL + " .. knobU, hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })
hl.bind("SUPER + CONTROL + " .. knobD, hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })

for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

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
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(noct("brightness increase")), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(noct("brightness decrease")), { locked = true, repeating = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd(noct("media next")), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd(noct("media playPause")), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(noct("media playPause")), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("media previous"))
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(noct("volume increase")), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(noct("volume decrease")), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(noct("volume muteOutput")), { locked = true, repeating = true })
