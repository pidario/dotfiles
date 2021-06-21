local awful = require('awful')
local gears = require('gears')
local wallpaper = require('configuration.apps').wallpaper
local set = function()
	awful.spawn.with_shell(wallpaper)
end
local timer = function ()
	local timer = gears.timer.start_new(1800, function()
		set()
		-- Signal that the timer should continue running
		return true
	end)
	-- Cause the callback function to run right now
	timer:emit_signal("timeout")
end
return {
	set = set;
	timer = timer;
}

