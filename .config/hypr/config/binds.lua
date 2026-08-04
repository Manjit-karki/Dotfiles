local mainMod = "SUPER"

-- Execution mods
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(TERMINAL))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(FILE_MANAGER))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + P", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))

-- Launch Apps
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(MENU))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(DRAW))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(NOTE))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(BLENDER))
hl.bind(mainMod .. " + SHIFT" .. " + SPACE", hl.dsp.exec_cmd(WALLPAPER))
hl.bind(mainMod .. " + SHIFT" .. " + S", hl.dsp.exec_cmd(SCREEN_SHOT))


-- Move Focus 
hl.bind(mainMod .. " + h",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l",  hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k",  hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j",  hl.dsp.focus({ direction = "down" }))

-- Switch workspaces 
-- Move active window to workspace
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Move Window
hl.bind(" ALT + " .. " + SHIFT + " .. " + h ", hl.dsp.window.move({ direction = "left" }))
hl.bind(" ALT + " .. " + SHIFT + " .. " + l ", hl.dsp.window.move({ direction = "right" }))
hl.bind(" ALT + " .. " + SHIFT + " .. " + j ", hl.dsp.window.move({ direction = "down" }))
hl.bind(" ALT + " .. " + SHIFT + " .. " + k ", hl.dsp.window.move({ direction = "up" }))

-- Resize Window ? (not very sure if it'll work)
-- hl.bind(mainMod .. " ALT + " .. " + h ", hl.dsp.window.resizeactive({ direction = "left" }))
-- hl.bind(mainMod .. " ALT + " .. " + l ", hl.dsp.window.resizeactive({ direction = "right" }))
-- hl.bind(mainMod .. " ALT + " .. " + j ", hl.dsp.window.resizeactive({ direction = "down" }))
-- hl.bind(mainMod .. " ALT + " .. " + k ", hl.dsp.window.resizeactive({ direction = "up" }))

-- Move Floating Window
-- hl.bind(" ALT + " .. " + CTRL + " .. " + h ", hl.dsp.window.moveactive({ direction = "left" }))
-- hl.bind(" ALT + " .. " + CTRL + " .. " + l ", hl.dsp.window.moveactive({ direction = "right" }))
-- hl.bind(" ALT + " .. " + CTRL + " .. " + j ", hl.dsp.window.moveactive({ direction = "down" }))
-- hl.bind(" ALT + " .. " + CTRL + " .. " + k ", hl.dsp.window.moveactive({ direction = "up" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
