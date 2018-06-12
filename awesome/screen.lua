-- Screen utility functions and widget declarations

local awful         = require('awful')
local beautiful     = require('beautiful')
local hotkeys_popup = require('awful.hotkeys_popup').widget
local wibox         = require('wibox')

local Mouse = require('mouse')

local TAGS = { '1', '2', '3', '4', '5', '6', '7', '8', '9' }

local MAIN_MENU = awful.menu({
  items = {
    { 'terminal', 'urxvt' },
    { 'hotkeys', function() return false, hotkeys_popup.show_help end },
    { 'restart', awesome.restart },
    { 'quit', awesome.quit }
  }
})

local function taglist_for_screen(s)
  return awful.widget.taglist(
    s,
    awful.widget.taglist.filter.all,
    awful.util.table.join(
      awful.button({}, Mouse.scroll.UP,   function() awful.tag.viewprev() end),
      awful.button({}, Mouse.scroll.DOWN, function() awful.tag.viewnext() end)
    )
  )
end

local Screen = {}

function Screen.on_connect(s)
  awful.tag(TAGS, s, awful.layout.layouts[1])

  -- mypromptbox is used by keybinds!
  s.mypromptbox = awful.widget.prompt()

  awful.wibar({ position = 'top', screen = s }):setup({
    layout = wibox.layout.align.horizontal,
    {
      layout = wibox.layout.fixed.horizontal,

      awful.widget.launcher({
        image = beautiful.awesome_icon,
        menu = MAIN_MENU
      }),
      taglist_for_screen(s),
      s.mypromptbox,
    },
    awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags),
    {
      layout = wibox.layout.fixed.horizontal,

      awful.widget.keyboardlayout(),
      wibox.widget.systray(),
      wibox.widget.textclock(),
    },
  })
end

function Screen.run()
  awful.screen.focused().mypromptbox:run()
end

return Screen
