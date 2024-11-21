local wezterm = require("wezterm")
local module = {}

function module.apply_to_config(config)
	config.default_prog =
		{ "C:/Users/HP/AppData/Local/Microsoft/WindowsApps/Microsoft.PowerShell_8wekyb3d8bbwe/pwsh.exe" }

	config.font_dirs = { "C:/Windows/Fonts" }
	config.tab_max_width = 4
	config.font = wezterm.font({ family = "JetBrains Mono" })
	config.font_size = 10.0

	-- config.color_scheme = "Rosé Pine Dawn (base16)"
	config.color_scheme = "Catppuccin Macchiato"

	-- Acrylic Style
	config.window_background_opacity = 0.9
	config.win32_system_backdrop = "Acrylic"

	-- config tabbar
	config.tab_bar_at_bottom = true
	config.use_fancy_tab_bar = false
	config.tab_and_split_indices_are_zero_based = true
	config.hide_tab_bar_if_only_one_tab = false

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

	-- tmux status
	wezterm.on("update-right-status", function(window, _)
		-- local SOLID_RIGHT_ARROW = ""
		local ARROW_FOREGROUND = { Foreground = { Color = "#c6a0f6" } }
		local prefix = ""

		if window:leader_is_active() then
			prefix = " " .. utf8.char(0x1f30a) -- ocean wave
			-- SOLID_RIGHT_ARROW = utf8.char(0xe0b3)
		end

		if window:active_tab():tab_id() ~= 0 then
			ARROW_FOREGROUND = { Foreground = { Color = "#1e2030" } }
		end -- arrow color based on if tab is first pane

		window:set_right_status(wezterm.format({
			{ Background = { Color = "#b7bdf8" } },
			{ Text = prefix },
			ARROW_FOREGROUND,
		}))
	end)
end
return module
