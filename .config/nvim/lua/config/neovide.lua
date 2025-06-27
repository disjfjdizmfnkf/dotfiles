if vim.g.neovide then
  -- 设置透明度 (0.0 完全透明, 1.0 完全不透明)
  vim.g.neovide_opacity = 0.77

  -- cursor
  vim.g.neovide_cursor_vfx_mode = ""
  vim.g.neovide_cursor_vfx_opacity = 250
  vim.g.neovide_cursor_vfx_particle_density = 10.0
  vim.g.neovide_cursor_vfx_particle_lifetime = 0.8
  vim.g.neovide_cursor_vfx_type = "wave"
  vim.g.neovide_cursor_antialiasing = true
  -- vim.g.neovide_cursor_animation_length = 0 -- 减少光标动画时间
  -- vim.g.neovide_cursor_trail_size = 0 -- 禁用光标拖尾效果
  -- 启用全屏模式
  vim.g.neovide_fullscreen = true

  -- 设置字体和字体大小
  -- Fira Code SemiBold
  vim.o.guifont = "Fira Code SemiBold"
  vim.g.neovide_font_size = 14 -- 字体大小

  -- 启用抗锯齿
  vim.g.neovide_antialiasing = true

  -- 启用 ClearType 字体渲染
  vim.g.neovide_clear_type = true

  -- 设置最大帧率
  vim.g.neovide_max_fps = 120

  -- 记住窗口位置
  vim.g.remember_window_position = true

  -- 记住窗口大小
  vim.g.remember_window_size = true

  -- 映射 F11 键切换全屏
  vim.keymap.set("n", "<F11>", function()
    vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
  end, { noremap = true, silent = true })

  -- 映射 F10 键切换透明度
  vim.keymap.set("n", "<F10>", function()
    vim.g.neovide_opacity = (vim.g.neovide_opacity == 0.77) and 1.0 or 0.77
  end, { silent = true })
end
