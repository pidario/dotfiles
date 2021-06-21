local awful = require('awful')
local beautiful = require('beautiful')

local tags = {1, 2, 3, 4, 5, 6, 7, 8, 9}

_G.tag.connect_signal(
	'request::default_layouts',
	function()
		awful.layout.append_default_layouts({
			awful.layout.suit.tile,
			awful.layout.suit.spiral.dwindle,
			awful.layout.suit.max,
			awful.layout.suit.floating
		})
	end
)

_G.screen.connect_signal(
	'request::desktop_decoration',
	function(s)
		for i, tag in pairs(tags) do
			awful.tag.add(
				tag,
				{
					layout = awful.layout.suit.tile,
					gap_single_client = true,
					gap = beautiful.useless_gap,
					screen = s,
					selected = i == 1
				}
			)
		end
	end
)

_G.tag.connect_signal(
	'property::layout',
	function(t)
		t.gap = beautiful.useless_gap
	end
)
