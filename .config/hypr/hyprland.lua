------------------
---- MONITORS ----
------------------

hl.monitor({
	output = "desc:Chimei Innolux Corporation 0x1521",
	mode = "1920x1080@144",
	position = "0x1080",
	scale = 1,
})
hl.monitor({
	output = "desc:Lenovo Group Limited LEN L28u-30 U1B3M25V",
	mode = "3840x2160@60",
	position = "1920x0",
	scale = 1,
})
hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = 1,
})

-------------------
---- VARIABLES ----
-------------------

-- Applications.
local terminal = "kitty"
local fileManager = "nemo"
local browser = "zen-browser"
local menu = "pkill rofi || rofi -modes 'drun' -show drun -show-icons -normal-window"
local clipboardHistory = 'pkill rofi || selected="$(cliphist list | rofi -dmenu -i -display-columns 2)" && echo "$selected" | cliphist decode | wl-copy'

local desktopShell = "~/Code/desktopshell/desktopshell"

-- Main modifier key for keybinds.
local mainMod = "SUPER"

-- Touchpad device names for toggling.
-- Run `hyprctl devices` to find the names.
local touchpadDevices = {
	"pnp0c50:0e-06cb:7e7e-touchpad",
}

-- Window classes to opacities.
local opacities = {
	["discord|Vencord"] = "0.90",
	["Slack"] = "0.90",
	["Spotify"] = "0.80",

	["kitty"] = "0.85",
	["Alacritty"] = "0.85",
	["foot"] = "0.85",
	["org.wezfurlong.wezterm"] = "0.85",
	["tilix"] = "0.85",
}

-- Window classes to explicitly tile.
local tiled = {
	"Aseprite",
	"Minecraft Linux Launcher UI",
	"mcpelauncher-client",
}

-- Window classes to explicitly float.
local floated = {
	"yad",
}

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
	hl.exec_cmd("hyprsunset")
	hl.exec_cmd("hyprpaper")

	hl.exec_cmd("systemctl --user start xsettingsd.service")
	hl.exec_cmd("uwsm-app -- xembedsniproxy")

	hl.exec_cmd("uwsm-app -- wl-paste --type text --watch cliphist store")
	hl.exec_cmd("uwsm-app -- wl-paste --type image --watch cliphist store")

	hl.exec_cmd("uwsm-app -- ydotoold")
	hl.exec_cmd("uwsm-app -- udiskie")
	hl.exec_cmd("uwsm-app -- openrgb -p reaper")
	hl.exec_cmd("uwsm-app -- mcontrolcenter")

	hl.exec_cmd("~/.config/hypr/scripts/mute_leds.sh")
	hl.exec_cmd('batsignal -w 15 -c 10 -d 5 -D \'notify-send --urgency=critical --icon=dialog-warning "Battery is dangerously low" "Plug in now!"\'')

	hl.exec_cmd("hyprgroups watch")
	hl.exec_cmd(desktopShell)
end)

hl.on("config.reloaded", function()
	--
end)

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
	general = {
		gaps_in = 2,
		gaps_out = 5,

		border_size = 2,

		col = {
			active_border = "rgba(137,180,250,0.7)",
			inactive_border = "rgba(127,132,156,0.5)",
		},

		-- Set to true to enable resizing windows by clicking and dragging on borders and gaps
		resize_on_border = false,

		-- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
		allow_tearing = false,

		layout = "dwindle",
	},

	decoration = {
		rounding = 6,
		rounding_power = 2,

		-- Change transparency of focused and unfocused windows
		active_opacity = 1.0,
		inactive_opacity = 1.0,

		border_part_of_window = false,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = 0x1a1a1aee,
		},

		blur = {
			enabled = true,
			size = 2,
			passes = 4,
			vibrancy = 0.1696,
		},
	},

	cursor = {
		no_hardware_cursors = true,
	},

	animations = {
		enabled = true,
	},
})

-- TODO: Speed up window opening and closing animations a bit (and some others)

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

hl.curve("easy", { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, spring = "easy", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.13, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.58, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.58, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

hl.config({
	dwindle = {
		preserve_split = true, -- You probably want this
	},
})

hl.config({
	master = {
		new_status = "master",
	},
})

hl.config({
	scrolling = {
		fullscreen_on_one_column = true,
	},
})

--------------
---- MISC ----
--------------

hl.config({
	misc = {
		force_default_wallpaper = -1, -- Set to 0 or 1 to disable the anime mascot wallpapers
		disable_hyprland_logo = false, -- If true disables the random hyprland logo / anime girl background. :(
	},
})

---------------
---- INPUT ----
---------------

hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "",
		kb_rules = "",

		follow_mouse = 1,

		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

		touchpad = {
			natural_scroll = true,
			disable_while_typing = false,
		},
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

---------------------
---- KEYBINDINGS ----
---------------------

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("uwsm-app -- " .. terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("uwsm-app -- " .. fileManager))
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd("uwsm-app -- " .. browser))
hl.bind(mainMod .. " + " .. mainMod .. "_L", hl.dsp.exec_cmd(menu), { release = true })
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd(clipboardHistory))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"), { submap_universal = true })

hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.kill())
-- hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("hyprctl activewindow | grep pid | tr -d 'pid:' | xargs kill"))

hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- dwindle only

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
	if w ~= nil and w.workspace.name:find("^special:") then
		local ws = hl.get_active_workspace()
		hl.dispatch(hl.dsp.window.move({ workspace = ws.id, follow = false }))
	else
		hl.dispatch(hl.dsp.window.move({ workspace = "special", follow = false }))
	end
end)
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.workspace.toggle_special(""))

hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))

-- hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle_bar.sh"))
-- hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("pkill desktopshell || " .. desktopShell))

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
-- XF86TouchpadToggle isn't working for some reason, but CTRL+SUPER+F24 is triggering.
hl.bind("CTRL + SUPER + F24", function()
	touchpadsEnabled = not touchpadsEnabled
	for _, device in ipairs(touchpadDevices) do
		hl.device({
			name = device,
			enabled = touchpadsEnabled,
		})
	end
end, { locked = true })

hl.bind("Print", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind("CTRL + Print", hl.dsp.exec_cmd("hyprshot -m output"))

hl.bind("SUPER + Print", hl.dsp.exec_cmd("hyprpicker --autocopy"))

hl.bind("CTRL + ALT + Delete", hl.dsp.exec_cmd("pkill rofi || rofi -show power-menu -modi power-menu:rofi-power-menu"))

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- Ignore maximize requests from all apps. You'll probably like this.
hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

-- Hide XWayland helper windows that have an empty title (common for Wine tray/menu helpers)
hl.window_rule({
	name = "hide-xwayland-helpers",
	match = {
		class = "^$",
		title = "^$",
		initial_class = "^$",
		initial_title = "^$",
		xwayland = true,
	},

	size = { 0, 0 },
	opacity = "0.0",
	float = true,
	no_blur = true,
})

hl.window_rule({
	match = { class = "firefox|zen", fullscreen = true },

	no_dim = true,
})
hl.window_rule({
	match = { class = "firefox|zen", title = "Picture-in-Picture" },

	-- no_blur = true,
	-- no_dim = true,
	tag = "nodim",
	float = true,
	pin = true,
	keep_aspect_ratio = true,
})

hl.window_rule({
	match = { tag = "nodim" },

	no_dim = true,
})

hl.window_rule({
	match = { content = "game" },

	render_unfocused = true,
})

hl.layer_rule({
	match = { namespace = "rofi" },

	blur = true,
	dim_around = true,
	ignore_alpha = 0.5,
})

for class, opacity in pairs(opacities) do
	hl.window_rule({
		match = { class = class },

		opacity = opacity,
	})
end

for _, class in ipairs(tiled) do
	hl.window_rule({
		match = { class = class },

		tile = true,
	})
end

for _, class in ipairs(floated) do
	hl.window_rule({
		match = { class = class },

		float = true,
	})
end
