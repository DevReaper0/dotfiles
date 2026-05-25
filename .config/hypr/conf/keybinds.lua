-- Applications.
local terminal = "kitty"
local fileManager = "nemo"
local browser = "zen-browser"
local menu = "pkill rofi || rofi -modes 'drun' -show drun -show-icons -normal-window"
local clipboardHistory = 'pkill rofi || selected="$(cliphist list | rofi -dmenu -i -display-columns 2)" && echo "$selected" | cliphist decode | wl-copy'

-- Main modifier key for keybinds.
local mainMod = "SUPER"

-- Touchpad device names for toggling.
-- Run `hyprctl devices` to find the names.
local touchpadDevices = {
	"pnp0c50:0e-06cb:7e7e-touchpad",
}

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("uwsm-app -- " .. terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("uwsm-app -- " .. fileManager))
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd("uwsm-app -- " .. browser))
hl.bind(mainMod .. " + " .. mainMod .. "_L", hl.dsp.exec_cmd(menu), { release = true })
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd(clipboardHistory))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"), { submap_universal = true })

hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.kill())

-- Layout toggle (dwindle)
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.exec_cmd("hyprgroups workspace switch -- " .. i))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.exec_cmd("hyprgroups workspace move -- " .. i))
end

-- This is necessary to prevent workspace switching keybinds from occasionally triggering.
-- It acts the same as modifier keys do.
hl.bind(mainMod .. " + grave", hl.dsp.submap("mod_grave"))
hl.define_submap("mod_grave", function()
	for i = 1, 10 do
		local key = i % 10
		hl.bind(tostring(key), hl.dsp.exec_cmd("hyprgroups group switch -- " .. i))
		hl.bind(mainMod .. " + grave + " .. key, hl.dsp.exec_cmd("hyprgroups group switch -- " .. i))
	end
	hl.bind(mainMod .. " + grave", hl.dsp.submap("reset"), { release = true, transparent = true })
	hl.bind(mainMod .. " + " .. mainMod .. "_L", hl.dsp.submap("reset"), { release = true, transparent = true })
	hl.bind("grave", hl.dsp.submap("reset"), { release = true, transparent = true })
	hl.bind("catchall", hl.dsp.submap("reset"))
end)

hl.bind(mainMod .. " + minus", hl.dsp.exec_cmd("hyprgroups workspace switch -- -1"))
hl.bind(mainMod .. " + equal", hl.dsp.exec_cmd("hyprgroups workspace switch -- +1"))
hl.bind(mainMod .. " + SHIFT + minus", hl.dsp.exec_cmd("hyprgroups workspace move -- -1"))
hl.bind(mainMod .. " + SHIFT + equal", hl.dsp.exec_cmd("hyprgroups workspace move -- +1"))

hl.bind(mainMod .. " + CTRL + left", hl.dsp.exec_cmd("hyprgroups workspace switch -- e-1"))
hl.bind(mainMod .. " + CTRL + right", hl.dsp.exec_cmd("hyprgroups workspace switch -- e+1"))
hl.bind(mainMod .. " + CTRL + SHIFT + left", hl.dsp.exec_cmd("hyprgroups workspace move -- e-1"))
hl.bind(mainMod .. " + CTRL + SHIFT + right", hl.dsp.exec_cmd("hyprgroups workspace move -- e+1"))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.exec_cmd("hyprgroups workspace switch -- e-1"))
hl.bind(mainMod .. " + mouse_up", hl.dsp.exec_cmd("hyprgroups workspace switch -- e+1"))
hl.bind(mainMod .. " + SHIFT + mouse_down", hl.dsp.exec_cmd("hyprgroups workspace move -- e-1"))
hl.bind(mainMod .. " + SHIFT + mouse_up", hl.dsp.exec_cmd("hyprgroups workspace move -- e+1"))

hl.bind(mainMod .. " + G", hl.dsp.exec_cmd("pkill rofi || hyprgroups group list | rofi -dmenu -i -on-entry-accepted \"hyprgroups group switch -- '{entry}'\""))
hl.bind(mainMod .. " + SHIFT + G", hl.dsp.exec_cmd("pkill rofi || ~/.config/hypr/scripts/hyprgroups-substitute-menu.sh"))

hl.bind(mainMod .. " + C", function()
	local w = hl.get_active_window()
	local ws = hl.get_active_workspace()
	if w ~= nil and ws ~= nil and w.workspace.name:find("^special:") then
		hl.dispatch(hl.dsp.window.move({ workspace = ws.id, follow = false }))
	else
		hl.dispatch(hl.dsp.window.move({ workspace = "special", follow = false }))
	end
end)
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.workspace.toggle_special(""))

hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Resize with locked aspect ratio
local aspectRatioRule = hl.window_rule({
	name = "aspect-ratio-resize",
	enabled = false,
	match = { focus = true },

	keep_aspect_ratio = true,
})
hl.bind(mainMod .. " + SHIFT + mouse:273", function()
	aspectRatioRule:set_enabled(true)
	hl.dispatch(hl.dsp.window.resize())
end, { mouse = true })
hl.bind(mainMod .. " + SHIFT + mouse:273", function()
	aspectRatioRule:set_enabled(false)
end, { mouse = true, release = true })

hl.bind(mainMod .. " + T", hl.dsp.window.pin())
hl.bind(mainMod .. " + Y", hl.dsp.window.tag({ tag = "nodim" }))

hl.bind(mainMod .. " + SHIFT + L", hl.dsp.submap("nobinds"))
hl.define_submap("nobinds", function()
	hl.bind(mainMod .. " + SHIFT + U", hl.dsp.submap("reset"))
end)

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("CTRL + XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%+"), { locked = true, repeating = true })
hl.bind("CTRL + XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"), { locked = true, repeating = true })
hl.bind("SHIFT + XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("SHIFT + XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("CTRL + SHIFT + XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+"), { locked = true, repeating = true })
hl.bind("CTRL + SHIFT + XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true })
hl.bind("CTRL + XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 1%+"), { locked = true, repeating = true })
hl.bind("CTRL + XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 1%-"), { locked = true, repeating = true })
hl.bind("SHIFT + XF86MonBrightnessUp", hl.dsp.exec_cmd("hyprctl hyprsunset gamma +5"), { locked = true, repeating = true })
hl.bind("SHIFT + XF86MonBrightnessDown", hl.dsp.exec_cmd("hyprctl hyprsunset gamma -5"), { locked = true, repeating = true })
hl.bind("CTRL + SHIFT + XF86MonBrightnessUp", hl.dsp.exec_cmd("hyprctl hyprsunset gamma +1"), { locked = true, repeating = true })
hl.bind("CTRL + SHIFT + XF86MonBrightnessDown", hl.dsp.exec_cmd("hyprctl hyprsunset gamma -1"), { locked = true, repeating = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

local touchpadsEnabled = true
local function toggleTouchpads()
	touchpadsEnabled = not touchpadsEnabled
	for _, device in ipairs(touchpadDevices) do
		hl.device({
			name = device,
			enabled = touchpadsEnabled,
		})
	end
end
hl.bind("XF86TouchpadToggle", toggleTouchpads, { locked = true })
-- XF86TouchpadToggle hasn't been working for me for some reason, but CTRL+SUPER+F24 is triggering.
hl.bind("CTRL + SUPER + F24", toggleTouchpads, { locked = true })

hl.bind("Print", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind("CTRL + Print", hl.dsp.exec_cmd("hyprshot -m output"))

hl.bind("SUPER + Print", hl.dsp.exec_cmd("hyprpicker --autocopy"))

hl.bind("CTRL + ALT + Delete", hl.dsp.exec_cmd("pkill rofi || rofi -show power-menu -modi power-menu:rofi-power-menu"))
