local wibox = require('wibox')
local beautiful = require('beautiful')

local clickable_container = function(widget)

	local container = wibox.widget {
		widget,
		widget = wibox.container.background
	}

	-- Mouse hovers on the widget
	container:connect_signal(
		'mouse::enter',
		function()
			container.bg = beautiful.groups_bg
		end
	)

	-- Mouse leaves the widget
	container:connect_signal(
		'mouse::leave',
		function()
			container.bg = beautiful.leave_event
		end
	)

	-- Mouse pressed the widget
	container:connect_signal(
		'button::press',
		function()
			container.bg = beautiful.press_event
		end
	)

	-- Mouse releases the widget
	container:connect_signal(
		'button::release',
		function()
			container.bg = beautiful.release_event
		end
	)

	return container
end

--- Common method to create buttons.
-- @tab buttons
-- @param object
-- @treturn table
local function create_buttons(buttons, object)
	if buttons then
		local btns = {}
		for _, b in ipairs(buttons) do
			-- Create a proxy button object: it will receive the real
			-- press and release events, and will propagate them to the
			-- button object the user provided, but with the object as
			-- argument.
			local btn = _G.button {modifiers = b.modifiers, button = b.button}
			btn:connect_signal(
				'press',
				function()
					b:emit_signal('press', object)
				end
			)
			btn:connect_signal(
				'release',
				function()
					b:emit_signal('release', object)
				end
			)
			btns[#btns + 1] = btn
		end

		return btns
	end
end

return {
	clickable_container = clickable_container,
	create_buttons = create_buttons,
}
