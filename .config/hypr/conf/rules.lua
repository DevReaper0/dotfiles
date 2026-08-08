-- Window classes to opacities.
local opacities = {
	["discord|Vencord"] = "0.90",
	["Slack"] = "0.90",
	["Spotify"] = "0.80",

	["kitty"] = "0.92",
	["Alacritty"] = "0.92",
	["com.mitchellh.ghostty"] = "0.92",
	-- ["foot"] = "0.92", -- Blur only works if the alpha is set in foot's own config.
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
