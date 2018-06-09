local naughty = require('naughty')

local Runtime = {}

local function errRuntime(err)
  return {
    preset = naughty.config.presets.critical,
    title = 'Oops, an error happened!',
    text = tostring(err)
  }
end

-- Handle runtime errors after startup
function Runtime.on_debug_error(cb)
  local in_error = false
  return function(err)
    -- Make sure we don't go into an endless error loop
    if not in_error then
      in_error = true
      cb(errRuntime(err))
    end
  end
end

return Runtime
