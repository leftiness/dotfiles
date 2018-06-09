local os = require('os')

local awful = require('awful')
require('awful.autofocus')
local beautiful = require('beautiful')
local naughty = require('naughty')
local hotkeys_popup = require('awful.hotkeys_popup').widget

local Mod = require('mod')
local Mouse = require('mouse')
local Runtime = require('runtime')
local Screen = require('screen')

local DEFAULT_THEME = 'default/theme.lua'
local SIGNAL_DEBUG = 'debug::error'
local CMD_NITROGEN = 'nitrogen --restore'

awesome.connect_signal(
  SIGNAL_DEBUG,
  Runtime.on_debug_error(naughty.notify)
)

beautiful.init(awful.util.get_themes_dir() .. DEFAULT_THEME)
os.execute(CMD_NITROGEN)

awful.layout.layouts = { awful.layout.suit.tile }
awful.screen.connect_for_each_screen(Screen.on_connect)

-- {{{ Key bindings
globalkeys = awful.util.table.join(
  awful.key(
    Mod.SUPER,
    's',
    hotkeys_popup.show_help,
    { description = 'show help', group = 'awesome' }
  ),
  awful.key(
    Mod.SUPER_SHIFT,
    'h',
    awful.tag.viewprev,
    { description = 'view previous', group = 'tag' }
  ),
  awful.key(
    Mod.SUPER_SHIFT,
    'l',
    awful.tag.viewnext,
    { description = 'view next', group = 'tag'}
  ),
  awful.key(
    Mod.SUPER,
    'j',
    function () awful.client.focus.byidx(1) end,
    { description = 'focus next by index', group = 'client' }
  ),
  awful.key(
    Mod.SUPER,
    'k',
    function () awful.client.focus.byidx(-1) end,
    { description = 'focus previous by index', group = 'client' }
  ),
  awful.key(
    Mod.SUPER_SHIFT,
    'r',
    awesome.restart,
    { description = 'reload awesome', group = 'awesome' }
  ),
  awful.key(
    Mod.SUPER_SHIFT,
    'q',
    awesome.quit,
    { description = 'quit awesome', group = 'awesome' }
  ),
  awful.key(
    Mod.SUPER,
    'l',
    function () awful.tag.incmwfact(0.05) end,
    { description = 'increase master width factor', group = 'layout' }
  ),
  awful.key(
    Mod.SUPER,
    'h',
    function () awful.tag.incmwfact(-0.05) end,
    { description = 'decrease master width factor', group = 'layout' }
  ),
  awful.key(
    Mod.SUPER,
    'space',
    function () awful.screen.focused().mypromptbox:run() end,
    { description = 'run prompt', group = 'launcher' }
  )
)

clientkeys = awful.util.table.join(
  awful.key(
    Mod.SUPER,
    'f',
    function (c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
    { description = 'toggle fullscreen', group = 'client' }
  ),
  awful.key(
    Mod.SUPER_SHIFT,
    'c',
    function (c) c:kill() end,
    { description = 'close', group = 'client' }
  ),
  awful.key(
    Mod.SUPER,
    'Return',
    function (c) c:swap(awful.client.getmaster()) end,
    { description = 'move to master', group = 'client' }
  ),
  awful.key(
    Mod.SUPER,
    'm',
    function (c)
      c.maximized = not c.maximized
      c:raise()
    end,
    { description = 'maximize', group = 'client' }
  )
)

-- Bind all key numbers to tags.
for i = 1, 9 do
  globalkeys = awful.util.table.join(
    globalkeys,
    awful.key(
      Mod.SUPER,
      '#' .. i + 9,
      function ()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          tag:view_only()
        end
      end,
      { description = 'view tag #'..i, group = 'tag' }
    ),
    awful.key(
      Mod.SUPER_SHIFT,
      '#' .. i + 9,
      function ()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:move_to_tag(tag)
          end
        end
      end,
      { description = 'move focused client to tag #'..i, group = 'tag' }
    )
  )
end

clientbuttons = awful.util.table.join(
  awful.button(
    {},
    Mouse.click.LEFT,
    function (c) client.focus = c; c:raise() end
  ),
  awful.button(Mod.SUPER, Mouse.click.LEFT, awful.mouse.client.move)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules

-- Rules to apply to new clients (through the 'manage' signal).
awful.rules.rules = {
  {
    rule = {},
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = clientkeys,
      buttons = clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap+awful.placement.no_offscreen,
      size_hints_honor = false
    }
  },

}
-- }}}

-- {{{ Signals

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal('mouse::enter', function (c) client.focus = c end)

-- Set border color on focus
client.connect_signal(
  'focus',
  function (c) c.border_color = beautiful.border_focus end
)

-- Set border color on unfocus
client.connect_signal(
  'unfocus',
  function (c) c.border_color = beautiful.border_normal end
)

-- }}}
