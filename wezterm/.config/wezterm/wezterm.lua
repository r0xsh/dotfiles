-- Imports
local load = require('lua.config.init').load

-- load events
require('lua.events')

local ui = require('lua.config.ui')
local keybinds = require('lua.config.keybinds')
local options = require('lua.config.options')

return load(ui, keybinds, options)
