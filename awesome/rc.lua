-- awesome_mode: api-level=4:screen=on

-- load luarocks if installed
pcall(require, 'luarocks.loader')

-- load theme
local beautiful = require'beautiful'
local awful = require'awful'
-- local gears = require'gears'
beautiful.init(require'themes.default.theme')

local M = {}

M.setupDisplay = function()
    awful.spawn('picom', false)
end

M.setupDisplay()

-- load key and mouse bindings
require'bindings'

-- load rules
require'rules'

-- load signals
require'signals'
