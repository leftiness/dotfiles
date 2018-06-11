local awful = require('awful')

local Tag = {}

function Tag.view(i)
  return function()
    awful.screen.focused().tags[i]:view_only()
  end
end

function Tag.grow()
  awful.tag.incmwfact(0.05)
end

function Tag.shrink()
  awful.tag.incmwfact(-0.05)
end

return Tag
