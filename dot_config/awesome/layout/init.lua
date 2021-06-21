local panel = require('layout.panel')

-- Create a wibox panel for each screen and add it
_G.screen.connect_signal(
	'request::desktop_decoration',
	function(s)
		s.panel = panel(s)
	end
)

-- Hide bars when app go fullscreen
local update_bars_visibility = function()
	for s in _G.screen do
		if s.selected_tag then
			local fullscreen = s.selected_tag.fullscreen_mode
			-- Order matter here for shadow
			if not s.panel then
				s.panel = panel(s)
			end
			s.panel.visible = not fullscreen
		end
	end
end

_G.tag.connect_signal(
	'property::selected',
	function()
		update_bars_visibility()
	end
)

_G.client.connect_signal(
	'property::fullscreen',
	function(c)
		if c.first_tag then
			c.first_tag.fullscreen_mode = c.fullscreen
		end
		update_bars_visibility()
	end
)

_G.client.connect_signal(
	'unmanage',
	function(c)
		if c.fullscreen then
			c.screen.selected_tag.fullscreen_mode = false
			update_bars_visibility()
		end
	end
)
