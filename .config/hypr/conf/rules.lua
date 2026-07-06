--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
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

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
    name = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move = "20 monitor_h-120",
    float = true,
})

----------------------
---- CUSTOM RULES ----
----------------------

-- move mullvad gui to top right
hl.window_rule({
    name = "mullvad-position",
    match = { class = "Mullvad VPN" },
    float = true,
    move = { "monitor_w-window_w-7", "43" },
})

hl.window_rule({
    name = "blueman-float",
    match = { class = "blueman-manager" },
    float = true,
})

hl.window_rule({
    name = "pavucontrol-float",
    match = { class = "org.pulseaudio.pavucontrol" },
    float = true,
})

-- FIX: doesn't work
-- hl.window_rule({
--     name = "nmtui-float",
--     match = { class = "com.mitchellh.ghostty", title = "nmtui" },
--     float = true,
-- })

hl.window_rule({
    name = "virtmanager-float",
    match = { class = "virt-manager" },
    float = true,
})
