local wibox = require('wibox')
local awful = require('awful')
local clickable_container = require('widget.common').clickable_container
local keyboard_widget = awful.widget.keyboardlayout()

local keyboard = function()
	_G.awesome.connect_signal(
		'widget::keyboard::next',
		function()
			keyboard_widget.next_layout()
		end
	)
	return wibox.widget {
		{	keyboard_widget,
			widget = wibox.container.margin
		},
		widget = clickable_container
	}
end

return keyboard
