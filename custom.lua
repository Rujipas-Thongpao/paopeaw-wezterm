local wezterm = require("wezterm")
-- local keys = require("keys")
local module = {}

function module.apply_to_config(config)
	config.default_prog =
		{ "C:/Users/HP/AppData/Local/Microsoft/WindowsApps/Microsoft.PowerShell_8wekyb3d8bbwe/pwsh.exe" }

	-- config font
	config.font_dirs = { "C:/Windows/Fonts" }
	config.tab_max_width = 4
	config.font = wezterm.font({ family = "JetBrains Mono", weight = "Bold" })

	-- config color_scheme
	-- config.color_scheme = "Rosé Pine Dawn (base16)"
	config.color_scheme = "Catppuccin Macchiato"

	-- config tabbar
	-- config.window_background_opacity = 0
	-- config.win32_system_backdrop = "Acrylic"
	config.hide_tab_bar_if_only_one_tab = true
	config.window_frame = {
		font = wezterm.font({ family = "JetBrains Mono", weight = "Bold" }),
		font_size = 12.0,
	}

	-- center window at start
	wezterm.on("gui-startup", function(cmd)
		local screen = wezterm.gui.screens().main
		local ratio = 0.8
		local width, height = screen.width * ratio, screen.height * ratio
		local tab, pane, window = wezterm.mux.spawn_window(cmd or {
			position = { x = (screen.width - width) / 2, y = (screen.height - height) / 2 },
		})
		window:gui_window():set_inner_size(width, height)
	end)

	config.window_decorations = "RESIZE"
end
return module
