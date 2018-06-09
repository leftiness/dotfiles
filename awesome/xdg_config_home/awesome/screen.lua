local awful = require('awful')
local beautiful = require('beautiful')
local hotkeys_popup = require('awful.hotkeys_popup')
local wibox = require('wibox')

local Mouse = require('mouse')

local MENU = awful.menu({
  items = {
    { 'terminal', 'urxvt' },
    { 'hotkeys', hotkeys_popup.widget.show_help },
    { 'restart', awesome.restart },
    { 'quit', awesome.quit }
  }
})

local TAG_BUTTONS = awful.util.table.join(
  awful.button({}, Mouse.click.LEFT, function (t) t:view_only() end),
  awful.button({}, Mouse.scroll.UP, function () awful.tag.viewprev() end),
  awful.button({}, Mouse.scroll.DOWN, function () awful.tag.viewnext() end)
)

local TAGS = { '1', '2', '3', '4', '5', '6', '7', '8', '9' }

local Screen = {}

function Screen.on_connect(s)
  awful.tag(TAGS, s, awful.layout.layouts[1])
  s.mypromptbox = awful.widget.prompt()

  s.mytaglist = awful.widget.taglist(
    s,
    awful.widget.taglist.filter.all,
    TAG_BUTTONS
  )

  s.mytasklist = awful.widget.tasklist(
    s,
    awful.widget.tasklist.filter.currenttags,
    awful.button({}, Mouse.click.LEFT, function (c) client.focus = c end)
  )

  s.mywibox = awful.wibar({ position = 'top', screen = s })

  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    -- Left widgets
    {
      layout = wibox.layout.fixed.horizontal,
      awful.widget.launcher({
        image = beautiful.awesome_icon,
        menu = MENU
      }),
      s.mytaglist,
      s.mypromptbox,
    },
    -- Middle widget
    s.mytasklist,
    -- Right widgets
    {
      layout = wibox.layout.fixed.horizontal,
      awful.widget.keyboardlayout(),
      wibox.widget.systray(),
      wibox.widget.textclock(),
    },
  }
end

return Screen
