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
	},

	decoration = {
		rounding = 6,
		rounding_power = 2,

		-- Change transparency of focused and unfocused windows
		active_opacity = 1.0,
		inactive_opacity = 1.0,

		border_part_of_window = false,

		blur = {
			enabled = true,
			size = 2,
			passes = 4,
			vibrancy = 0.1696,
		},

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = 0x1a1a1aee,
		},
	},

	cursor = {
		no_hardware_cursors = true,
	},
})
