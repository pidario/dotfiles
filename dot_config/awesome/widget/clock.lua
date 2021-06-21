local wibox = require('wibox')
local clickable_container = require('widget.common').clickable_container

local clock = function()
	return wibox.widget {
		{
			wibox.widget.textclock(),
			widget = wibox.container.margin
		},
		widget = clickable_container
	}
end

return clock
