local awful = require('awful')
local beautiful = require('beautiful')

local Signal = require('signal')

local Client = {}

function Client.next()
  awful.client.focus.byidx(1)
end

function Client.prev()
  awful.client.focus.byidx(-1)
end

function Client.fullscreen(c)
  c.fullscreen = not c.fullscreen
  c:raise()
end

function Client.maximize(c)
  c.maximized = not c.maximized
  c:raise()
end

function Client.focus(c)
  client.focus = c
  c:raise()
end

function Client.promote(c)
  c:swap(awful.client.getmaster())
end

function Client.kill(c)
  c:kill()
end

function Client.border_focus(c)
  c.border_color = beautiful.border_focus
end

function Client.border_normal(c)
  c.border_color = beautiful.border_normal
end

function Client.to_tag(i)
  return function()
    if client.focus then
      client.focus:move_to_tag(client.focus.screen.tags[i])
    end
  end
end

return Client
