local awful = require('awful')
local hotkeys = require('awful.hotkeys_popup').widget

local Client = require('client')
local Mod = require('mod')
local Mouse = require('mouse')
local Screen = require('screen')
local Tag = require('tag')

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
    .new_key(Mod.SUPER, 'l', Tag.grow),

  with_tip('shrink master', 'layout')
    .new_key(Mod.SUPER, 'h', Tag.shrink),

  with_tip('run prompt', 'launcher')
    .new_key(Mod.SUPER, 'space', Screen.run)
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

return Key
