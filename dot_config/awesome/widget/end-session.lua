local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local clickable_container = require('widget.common').clickable_container
local beautiful = require('beautiful')

local return_button = function()
	local widget = wibox.widget {
		{
			id = 'icon',
			image = beautiful.logout,
			resize = true,
			widget = wibox.widget.imagebox
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
					_G.awesome.emit_signal('module::exit_screen_show')
				end
			)
		)
	)

	return widget_button
end

return return_button
