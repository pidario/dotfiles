local wibox = require('wibox')
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi
local clickable_container = require('widget.common').clickable_container

return wibox.widget {
	{
		wibox.widget.textclock(),
		margins = dpi(5),
		widget = wibox.container.margin
	},
	widget = clickable_container
}
