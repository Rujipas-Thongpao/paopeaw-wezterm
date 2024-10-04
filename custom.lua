local wezterm = require("wezterm")
local keys = require("keys")
local theme = require("theme")
local module = {}

function module.apply_to_config(config)
	config.default_prog =
		{ "C:/Users/HP/AppData/Local/Microsoft/WindowsApps/Microsoft.PowerShell_8wekyb3d8bbwe/pwsh.exe" }
	theme.apply_to_config(config)
	keys.apply_to_config(config)
end
return module
