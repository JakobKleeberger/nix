-- HYPRLAND LUA CONFIGURATION (Hyprland 0.57+)

-- MONITORS

hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })
hl.monitor({ output = "eDP-1", mode = "1920x1200", position = "auto", scale = "1" })
hl.monitor({ output = "DP-4", mode = "preferred", position = "-1920x0", scale = "auto" })

-- VARIABLES

local terminal = "ghostty"
local fileManager = "yazi"
local menu = "noctalia msg panel-toggle launcher"
local mainMod = "SUPER"

-- AUTOSTART

hl.on("hyprland.start", function()
hl.exec_cmd("noctalia")
hl.exec_cmd("polkit-agent-helper-1")
hl.exec_cmd("systemctl start --user polkit-gnome-authentication-agent-1")
end)

-- ENVIRONMENT VARIABLES

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- LOOK AND FEEL & OPTIONS

hl.config({
    general = {
	gaps_in = 5,
	gaps_out = 10,
	border_size = 2,
	col = {
	    active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
	    inactive_border = "rgba(595959aa)",
	},
	resize_on_border = false,
	allow_tearing = false,
	layout = "dwindle",
    },

    decoration = {
    rounding = 20,
    active_opacity = 1.0,
    inactive_opacity = 1.0,
    shadow = {
        enabled = true,
        range = 4,
        render_power = 3,
        color = "rgba(1a1a1aee)",
    },
    blur = {
        enabled = true,
        size = 3,
        passes = 2,
        vibrancy = 0.1696,
    },
},

animations = {
    enabled = true
    -- bezier = "myBezier, 0.05, 0.9, 0.1, 1.05",
    -- animation = {
    --     "windows, 1, 7, myBezier",
    --     "windowsOut, 1, 7, default, popin 80%",
    --     "border, 1, 10, default",
    --     "borderangle, 1, 8, default",
    --     "fade, 1, 7, default",
    --     "workspaces, 1, 6, default",
    -- },
},

dwindle = {
    preserve_split = true,
},

master = {
    new_status = "master",
},

misc = {
    force_default_wallpaper = 0,
    disable_hyprland_logo = true,
},

input = {
    kb_layout = "de",
    follow_mouse = 1,
    sensitivity = 0,
    touchpad = {
        natural_scroll = true,
    },
},


})

-- KEYBINDINGS

-- Standard Binds
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.kill())
hl.bind(mainMod .. " + BACKSPACE", hl.dsp.exec_cmd("noctalia msg session lock-and-suspend"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(terminal .. " -e " .. fileManager))
hl.bind("Print", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())

-- Move windows in workspace
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "down" }))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Workspaces 1-10
for i = 1, 10 do
local key = i % 10 -- 10 entspricht Taste 0
-- Switch workspace
hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
-- Move active window to workspace
hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mouse wheel
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Mouse Binds (Move/Resize windows)
-- hl.bind(mainMod .. " + mouse:272", hl.dsp.window.move())
-- hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize())

-- Laptop multimedia keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("noctalia msg brightness-up"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("noctalia msg brightness-down"))
