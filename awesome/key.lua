local awful = require('awful')
local beautiful = require('beautiful')
local hotkeys = require('awful.hotkeys_popup').widget

local Mod = require('mod')
local Mouse = require('mouse')
local Signal = require('signal')

local Client = {}

function Client.next() awful.client.focus.byidx(1) end
function Client.prev() awful.client.focus.byidx(-1) end

function Client.fullscreen(c) c.fullscreen = not c.fullscreen; c:raise() end
function Client.maximize(c) c.maximized = not c.maximized; c:raise() end
function Client.focus(c) client.focus = c; c:raise() end
function Client.promote(c) c:swap(awful.client.getmaster()) end
function Client.kill(c) c:kill() end

function Client.border_focus(c) c.border_color = beautiful.border_focus end
function Client.border_normal(c) c.border_color = beautiful.border_normal end

function Client.to_tag(i)
  return function()
    if client.focus then
      client.focus:move_to_tag(client.focus.screen.tags[i])
    end
  end
end

local Master = {}
function Master.grow() awful.tag.incmwfact(0.05) end
function Master.shrink() awful.tag.incmwfact(-0.05) end

local Prompt = {}
function Prompt.run() awful.screen.focused().mypromptbox:run() end

local Tag = {}
function Tag.view(i)
  return function()
    awful.screen.focused().tags[i]:view_only()
  end
end

local Key = {}

function with_tip(desc, group)
  return {
    new_key = function(mod, key, op)
      return awful.key(mod, key, op, { description = desc, group = group })
    end
  }
end

Key.GLOBAL = awful.util.table.join(
  with_tip('show hotkey help', 'awesome')
    .new_key(Mod.SUPER_SHIFT, 's', hotkeys.show_help),

  with_tip('reload', 'awesome')
    .new_key(Mod.SUPER_SHIFT, 'r', awesome.restart),

  with_tip('quit', 'awesome')
    .new_key(Mod.SUPER_SHIFT, 'q', awesome.quit),

  with_tip('view previous', 'tag')
    .new_key(Mod.SUPER_SHIFT, 'h', awful.tag.viewprev),

  with_tip('view next', 'tag')
    .new_key(Mod.SUPER_SHIFT, 'l', awful.tag.viewnext),

  with_tip('focus next', 'client')
    .new_key(Mod.SUPER, 'j', Client.next),

  with_tip('focus previous', 'client')
    .new_key(Mod.SUPER, 'k', Client.prev),

  with_tip('grow master', 'layout')
    .new_key(Mod.SUPER, 'l', Master.grow),

  with_tip('shrink master', 'layout')
    .new_key(Mod.SUPER, 'h', Master.shrink),

  with_tip('run prompt', 'launcher')
    .new_key(Mod.SUPER, 'space', Prompt.run)
)

for i = 1, 9 do
  Key.GLOBAL = awful.util.table.join(
    Key.GLOBAL,

    with_tip('view #'..i, 'tag')
      .new_key(Mod.SUPER, '#'..i+9, Tag.view(i)),

    with_tip('move to tag #'..i, 'client')
      .new_key(Mod.SUPER_SHIFT, '#'..i+9, Client.to_tag(i))
  )
end

Key.CLIENT = awful.util.table.join(
  with_tip('toggle fullscreen', 'client')
    .new_key(Mod.SUPER, 'f', Client.fullscreen),

  with_tip('toggle maximize', 'client')
    .new_key(Mod.SUPER, 'm', Client.maximize),

  with_tip('promote to master', 'client')
    .new_key(Mod.SUPER, 'Return', Client.promote),

  with_tip('close', 'client')
    .new_key(Mod.SUPER_SHIFT, 'c', Client.kill)
)

Key.CLIENT_BUTTON = awful.util.table.join(
  awful.button({}, Mouse.click.LEFT, Client.focus),
  awful.button(Mod.SUPER, Mouse.click.LEFT, awful.mouse.client.move)
)

client.connect_signal(Signal.Client.MOUSE_ENTER, Client.focus)
client.connect_signal(Signal.Client.FOCUS, Client.border_focus)
client.connect_signal(Signal.Client.UNFOCUS, Client.border_normal)

return Key