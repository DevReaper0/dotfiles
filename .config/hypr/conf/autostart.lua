local desktopShell = "~/Code/desktopshell/desktopshell"

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
