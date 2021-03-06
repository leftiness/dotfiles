local os = require('os')

local awful = require('awful')
local beautiful = require('beautiful')
local gears = require('gears')
local wibox = require('wibox')

require('awful.autofocus')

local function vktox(v, k) return function(x) v[k] = x end end
local function xktov(k, v) return function(x) x[k] = v end end
local function xktoggle(k) return function(x) x[k] = not x[k] end end
local function bind(f, a) return function() f(a) end end

local function tag(i) return awful.screen.focused().tags[i] end
local function focus(i) tag(i):view_only() end
local function move(i) return function(c) c:move_to_tag(tag(i)) end end
local function kill(c) c:kill() end

os.execute('nitrogen --restore')
beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
beautiful.useless_gap = 10

awful.layout.layouts = { awful.layout.suit.tile }

local rootkeys = gears.table.join(
  awful.key({ 'Mod4', 'Shift' }, 'r', awesome.restart),
  awful.key({ 'Mod4', 'Shift' }, 'q', awesome.quit),

  awful.key({ 'Mod4' }, 'j', bind(awful.client.focus.byidx, 1)),
  awful.key({ 'Mod4' }, 'k', bind(awful.client.focus.byidx, -1)),

  awful.key({ 'Mod4' }, 'l', bind(awful.tag.incmwfact, 0.05)),
  awful.key({ 'Mod4' }, 'h', bind(awful.tag.incmwfact, -0.05)),

  awful.key({ 'Mod4' }, 'space', bind(os.execute, 'dmenu_run')),

  awful.key({ 'Mod4' }, '#'..1+9, bind(focus, 1)),
  awful.key({ 'Mod4' }, '#'..2+9, bind(focus, 2)),
  awful.key({ 'Mod4' }, '#'..3+9, bind(focus, 3)),
  awful.key({ 'Mod4' }, '#'..4+9, bind(focus, 4)),
  awful.key({ 'Mod4' }, '#'..5+9, bind(focus, 5)),
  awful.key({ 'Mod4' }, '#'..6+9, bind(focus, 6)),
  awful.key({ 'Mod4' }, '#'..7+9, bind(focus, 7)),
  awful.key({ 'Mod4' }, '#'..8+9, bind(focus, 8)),
  awful.key({ 'Mod4' }, '#'..9+9, bind(focus, 9))
)

local clientkeys = gears.table.join(
  awful.key({ 'Mod4' }, 'f', xktoggle('fullscreen')),
  awful.key({ 'Mod4' }, 'm', xktoggle('maximized')),
  awful.key({ 'Mod4' }, 'Return', awful.client.setmaster),
  awful.key({ 'Mod4', 'Shift' }, 'c', kill),
  awful.key({ 'Mod4', 'Shift' }, '#'..1+9, move(1)),
  awful.key({ 'Mod4', 'Shift' }, '#'..2+9, move(2)),
  awful.key({ 'Mod4', 'Shift' }, '#'..3+9, move(3)),
  awful.key({ 'Mod4', 'Shift' }, '#'..4+9, move(4)),
  awful.key({ 'Mod4', 'Shift' }, '#'..5+9, move(5)),
  awful.key({ 'Mod4', 'Shift' }, '#'..6+9, move(6)),
  awful.key({ 'Mod4', 'Shift' }, '#'..7+9, move(7)),
  awful.key({ 'Mod4', 'Shift' }, '#'..8+9, move(8)),
  awful.key({ 'Mod4', 'Shift' }, '#'..9+9, move(9))
)

local clientbuttons = gears.table.join(
  awful.button({}, 1, vktox(client, 'focus')),
  awful.button({ 'Mod4' }, 1, awful.mouse.client.move)
)

root.keys(rootkeys)

awful.rules.rules = {
  {
    rule = {},
    properties = {
      keys = clientkeys,
      buttons = clientbuttons,

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

local systray = {
  layout = wibox.layout.fixed.horizontal,
  awful.widget.keyboardlayout(),
  wibox.widget.systray(),
  wibox.widget.textclock()
}

local tags = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }

local tagbuttons = gears.table.join(
  awful.button({ }, 4, bind(awful.tag.viewidx, -1)),
  awful.button({ }, 5, bind(awful.tag.viewidx, 1))
)

local function connect(s)
  awful.tag(tags, s, awful.layout.layouts[1])

  awful.wibar({ position = "top", screen = s }):setup({
    layout = wibox.layout.align.horizontal,
    {
      layout = wibox.layout.fixed.horizontal,
      awful.widget.taglist(s, awful.widget.taglist.filter.all, tagbuttons)
    },
    awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags),
    systray
  })
end

awful.screen.connect_for_each_screen(connect)

client.connect_signal('mouse::enter', vktox(client, 'focus'))
client.connect_signal('focus', xktov('border_color', beautiful.border_focus))
client.connect_signal('unfocus', xktov('border_color', beautiful.border_normal))
