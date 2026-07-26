local M = {}

local function run_cmd(cmd) return hl.dsp.exec_cmd("noctalia msg " .. cmd) end

function M.start_shell() hl.exec_cmd("noctalia") end

-- kill v4 if it's up, then toggle v5
function M.toggle_shell() return hl.dsp.exec_cmd("pkill -x qs; pkill -x noctalia || noctalia") end
function M.run_cmd(cmd) return run_cmd(cmd) end
function M.settings() return run_cmd("settings-toggle") end
function M.bar_toggle() return run_cmd("bar-toggle") end
function M.dock_toggle() return run_cmd("dock-toggle") end
function M.dock_show() return run_cmd("dock-show") end
function M.dock_hide() return run_cmd("dock-hide") end
function M.launcher() return run_cmd("panel-toggle launcher") end
function M.session_menu() return run_cmd("panel-toggle session") end
function M.window_switcher() return run_cmd("window-switcher") end
function M.clipboard() return run_cmd("panel-toggle clipboard") end
function M.screenshot_region() return run_cmd("screenshot-region") end
function M.screenshot_fullscreen() return run_cmd("screenshot-fullscreen") end

function M.brightness_up() return run_cmd("brightness-up") end
function M.brightness_down() return run_cmd("brightness-down") end

function M.media_next() return run_cmd("media next") end
function M.media_prev() return run_cmd("media previous") end
function M.media_play_pause() return run_cmd("media toggle") end

function M.volume_up() return run_cmd("volume-up") end
function M.volume_down() return run_cmd("volume-down") end
function M.volume_mute() return run_cmd("volume-mute") end

return M
