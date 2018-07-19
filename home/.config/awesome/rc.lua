local os = require('os')

local awful     = require('awful')
local beautiful = require('beautiful')
local naughty   = require('naughty')

require('awful.autofocus')

local Client  = require('client')
local Key     = require('key')
local Runtime = require('runtime')
local Screen  = require('screen')
local Signal  = require('signal')

local DEFAULT_THEME     = awful.util.get_themes_dir() .. 'default/theme.lua'
local CMD_SET_WALLPAPER = 'nitrogen --restore'

awesome.connect_signal(
  Signal.Awesome.DEBUG_ERROR,
  Runtime.on_debug_error(naughty.notify)
)

client.connect_signal(Signal.Client.MOUSE_ENTER, Client.focus)
client.connect_signal(Signal.Client.FOCUS,       Client.border_color_focus)
client.connect_signal(Signal.Client.UNFOCUS,     Client.border_color_normal)

beautiful.init(DEFAULT_THEME)
os.execute(CMD_SET_WALLPAPER)

awful.layout.layouts = { awful.layout.suit.tile }
awful.screen.connect_for_each_screen(Screen.on_connect)

root.keys(Key.GLOBAL)

awful.rules.rules = {
  {
    rule = {},
    properties = {
      keys    = Key.CLIENT,
      buttons = Key.CLIENT_BUTTON,

      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,

      focus     = awful.client.focus.filter,
      screen    = awful.screen.preferred,
      placement = awful.placement.no_overlap+awful.placement.no_offscreen,

      raise            = true,
      size_hints_honor = false
    }
  }
}
