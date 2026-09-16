local wezterm = require('wezterm')
local colorscheme_dark = 'kanso-zen'
local colorscheme_light = 'kanso-pearl'
local font_family = 'Ioskeley Mono'

-- Pick the right color table based on OS appearance (Dark/Light)
local function scheme_for_appearance(appearance)
    if appearance:find('Dark') then
        return require('colors.' .. colorscheme_dark)
    end
    return require('colors.' .. colorscheme_light)
end

-- Initial colors for the first paint
local initial_colors = scheme_for_appearance(wezterm.gui.get_appearance())

-- Auto-switch light/dark when the system appearance changes
wezterm.on('window-config-reloaded', function(window)
    window:set_config_overrides {
        colors = scheme_for_appearance(wezterm.gui.get_appearance()),
    }
end)

return {

    -- UI
    window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
    max_fps = 60,
    -- front_end = 'WebGpu',

    -- Cursor
    animation_fps = 60,
    cursor_blink_ease_in = 'EaseOut',
    cursor_blink_ease_out = 'EaseOut',
    default_cursor_style = 'BlinkingBlock',
    cursor_blink_rate = 850,
    hide_mouse_cursor_when_typing = true,
    window_decorations = 'NONE',

    -- Status
    status_update_interval = 5000,

    -- Tabs
    hide_tab_bar_if_only_one_tab = false,
    tab_bar_at_bottom = true,
    use_fancy_tab_bar = false,
    tab_max_width = 25,
    switch_to_last_active_tab_when_closing_tab = true,

    -- Colors (auto-switches between dark/light based on system appearance)
    colors = initial_colors,
    force_reverse_video_cursor = true,

    -- Fonts
    font = wezterm.font {
        family = font_family,
        weight = 'Regular',
    },
    font_size = 12,
    harfbuzz_features = { 'calt = 0', 'clig = 0', 'liga = 0' },
    warn_about_missing_glyphs = false,
    freetype_load_target = 'Light',
    -- freetype_render_target = 'Normal',
    -- freetype_load_flags = 'FORCE_AUTOHINT',
}
