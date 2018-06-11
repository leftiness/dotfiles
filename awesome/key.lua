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

local Tip = {
  Awesome = {
    SHOW_HELP = { description = 'show help', group = 'awesome' },
    RELOAD =    { description = 'reload',    group = 'awesome' },
    QUIT =      { description = 'quit',      group = 'awesome' }
  },
  Tag = {
    PREVIOUS = { description = 'previous', group = 'tag' },
    NEXT =     { description = 'next',     group = 'tag' }
  },
  Client = {
    NEXT =     { description = 'next',     group = 'client' },
    PREVIOUS = { description = 'previous', group = 'client' },
    to_tag = function(i)
      return { description = 'move client to tag #'..i, group = 'client' }
    end,
    FULLSCREEN = { description = 'fullscreen',  group = 'client' },
    MAXIMIZE =   { description = 'maximize',    group = 'client' },
    PROMOTE =    { description = 'make master', group = 'client' },
    CLOSE =      { description = 'close',       group = 'client' }
  },
  Layout = {
    GROW =   { description = 'grow master',   group = 'layout' },
    SHRINK = { description = 'shrink master', group = 'layout' }
  },
  Prompt = {
    RUN = { description = 'run prompt', group = 'launcher' }
  },
  Tag = {
    view = function(i)
      return { description = 'view #'..i, group = 'tag' }
    end
  }
}

local Key = {}

Key.GLOBAL = awful.util.table.join(
  awful.key(Mod.SUPER_SHIFT, 's', hotkeys.show_help, Tip.Awesome.SHOW_HELP),
  awful.key(Mod.SUPER_SHIFT, 'r', awesome.restart,   Tip.Awesome.RELOAD),
  awful.key(Mod.SUPER_SHIFT, 'q', awesome.quit,      Tip.Awesome.QUIT),

  awful.key(Mod.SUPER_SHIFT, 'h', awful.tag.viewprev, Tip.Tag.PREVIOUS),
  awful.key(Mod.SUPER_SHIFT, 'l', awful.tag.viewnext, Tip.Tag.NEXT),

  awful.key(Mod.SUPER, 'j', Client.next, Tip.Client.NEXT),
  awful.key(Mod.SUPER, 'k', Client.prev, Tip.Client.PREVIOUS),

  awful.key(Mod.SUPER, 'l', Master.grow,   Tip.Layout.GROW),
  awful.key(Mod.SUPER, 'h', Master.shrink, Tip.Layout.SHRINK),

  awful.key(Mod.SUPER, 'space', Prompt.run, Tip.Prompt.RUN)
)

for i = 1, 9 do
  Key.GLOBAL = awful.util.table.join(
    Key.GLOBAL,
    awful.key(Mod.SUPER, '#'..i+9, Tag.view(i), Tip.Tag.view(i)),

    awful.key(Mod.SUPER_SHIFT, '#'..i+9, Client.to_tag(i), Tip.Client.to_tag(i))
  )
end

Key.CLIENT = awful.util.table.join(
  awful.key(Mod.SUPER, 'f', Client.fullscreen, Tip.Client.FULLSCREEN),
  awful.key(Mod.SUPER, 'm', Client.maximize,   Tip.Client.MAXIMIZE),

  awful.key(Mod.SUPER, 'Return', Client.promote, Tip.Client.PROMOTE),

  awful.key(Mod.SUPER_SHIFT, 'c', Client.kill, Tip.Client.CLOSE)
)

Key.CLIENT_BUTTON = awful.util.table.join(
  awful.button({},        Mouse.click.LEFT, Client.focus),
  awful.button(Mod.SUPER, Mouse.click.LEFT, awful.mouse.client.move)
)

client.connect_signal(Signal.Client.MOUSE_ENTER, Client.focus)
client.connect_signal(Signal.Client.FOCUS, Client.border_focus)
client.connect_signal(Signal.Client.UNFOCUS, Client.border_normal)

return Key
