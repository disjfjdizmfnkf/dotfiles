-- Shell 配置
local wezterm = require("wezterm")
local pwsh = { label = "PowerShell", args = { "C:/Program Files/PowerShell/7/pwsh.exe" } }
local cmd = { label = "MSYS / MSYS2", args = { "C:/msys64/msys2_shell.cmd", "-defterm", "-here", "-no-start" } }
local nu = { label = "nushell", args = { "C:/Users/86181/AppData/Local/Programs/nu/bin/nu.exe" } }
local launch_menu = { pwsh, cmd, nu }
local module = {}
function module.apply(config)
	-- 默认终端
	config.default_prog = nu.args
	-- shell 菜单列表
	config.launch_menu = launch_menu
end

return module
