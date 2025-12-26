local wezterm = require('wezterm')
local hyperlink_rules = wezterm.default_hyperlink_rules()
return {
    check_for_updates = false,
    audible_bell = 'Disabled',
    hyperlink_rules = hyperlink_rules,
}
