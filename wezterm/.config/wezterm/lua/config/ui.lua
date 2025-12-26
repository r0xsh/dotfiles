local wezterm = require('wezterm')
local colorscheme = 'kanso-zen'
local font_family = 'Ioskeley Mono'

return {

    -- UI
    window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
    max_fps = 60,
    front_end = 'Software',

    -- Cursor
    animation_fps = 60,
    cursor_blink_ease_in = 'EaseOut',
    cursor_blink_ease_out = 'EaseOut',
    default_cursor_style = 'BlinkingBlock',
    cursor_blink_rate = 850,

    -- Status
    status_update_interval = 5000,

    -- Tabs
    hide_tab_bar_if_only_one_tab = false,
    tab_bar_at_bottom = true,
    use_fancy_tab_bar = false,
    tab_max_width = 25,
    switch_to_last_active_tab_when_closing_tab = true,

    -- Colors
    colors = require('colors.' .. colorscheme),
    force_reverse_video_cursor = true,

    -- Fonts
    font = wezterm.font {
        family = font_family,
        weight = 'Medium',
    },
    font_size = 12,
    harfbuzz_features = { 'calt = 0', 'clig = 0', 'liga = 0' },
    freetype_load_target = 'Normal',
    freetype_render_target = 'Normal',
    -- freetype_load_flags = 'NO_HINTING',
}
