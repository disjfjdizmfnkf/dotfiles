-- 外观设定
local wezterm = require("wezterm")
local module = {}
function module.apply(config)
	--     local materia = wezterm.color.get_builtin_schemes()['Gruvbox dark, hard (base16)']
	-- materia.scrollbar_thumb = '#cccccc' -- 更明显的滚动条
	-- config.colors = materia

	-- 主题
	-- 自定义主题
	-- config.color_scheme_dirs(wezterm.config_dir .. "/assets/color_scheme/OneHalfDark.oml")
	-- config.colors = wezterm.color.load_scheme(wezterm.config_dir .. "/assets/color_scheme/OneHalfDark.oml")
	-- 预置主题 https://wezfurlong.org/wezterm/colorschemes/index.html
	-- 其他可获取主题的项目：
	-- iTerm2-Color-Schemes，https://github.com/mbadolato/iTerm2-Color-Schemes#screenshots
	-- base16，https://github.com/chriskempson/base16-schemes-source
	-- Gogh，https://gogh-co.github.io/Gogh/
	-- terminal.sexyhttps://terminal.sexy/
	-- config.color_scheme = "Aci (Gogh)"
	-- config.color_scheme = "Gruvbox Dark (Gogh)"
	-- config.color_scheme = "Breath Darker (Gogh)" -- manjaro 的感觉！
	-- 字体
	config.font = wezterm.font_with_fallback({
		{ family = "Fira Code", weight = "Medium" },
	})
	config.font_size = 14
	-- 窗口标题栏配置。隐藏系统标题栏，将窗口按钮集成到标签栏，允许调整窗口大小。
	config.window_decorations = "INTEGRATED_BUTTONS|RESIZE" --
	-- 窗口关闭确认，不弹出
	config.window_close_confirmation = "NeverPrompt"
	-- 标签的标题渲染，false 表示使用复古样式
	config.use_fancy_tab_bar = false
	-- 单标签页时隐藏标签栏
	-- config.hide_tab_bar_if_only_one_tab = true

	-- 背景不透明度
	config.window_background_opacity = 0
	-- 背景亚克力效果（Windows系统） Acrylic|Mica|Tabbed
	-- 窗口失去焦点时就失效了！不知道是否可配置成一直生效，github issue：https://github.com/wez/wezterm/issues/5895
	config.win32_system_backdrop = "Mica"
end

return module
