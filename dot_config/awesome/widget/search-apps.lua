local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local beautiful = require('beautiful')
local clickable_container = require('widget.common').clickable_container
local apps = require('configuration.apps')

local return_button = function()

	local widget = wibox.widget {
		{
			id = 'icon',
			image = beautiful.awesome_icon,
			widget = wibox.widget.imagebox,
			resize = true
		},
		layout = wibox.layout.align.horizontal
	}

	local widget_button = wibox.widget {
		{
			widget,
			margins = beautiful.button_margin,
			widget = wibox.container.margin
		},
		widget = clickable_container
	}

	widget_button:buttons(
		gears.table.join(
			awful.button(
				{},
				1,
				nil,
				function()
					awful.spawn(apps.launcher, false)
				end
			)
		)
	)

	return widget_button
end

return return_button
