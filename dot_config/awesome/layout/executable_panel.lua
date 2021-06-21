local beautiful = require('beautiful')
local wibox = require('wibox')
local dpi = beautiful.xresources.apply_dpi
local task_list = require('widget.task-list')
local tag_list = require('widget.tag-list')
local clock = require('widget.clock')

local panel = function(s)
	local panel = wibox {
		ontop = true,
		screen = s,
		type = 'dock',
		height = beautiful.bp_height,
		width = s.geometry.width,
		x = s.geometry.x,
		y = 0,
		stretch = true,
	}

	panel:struts {
		top = beautiful.bp_height
	}

	local build_widget = function(widget)
		return wibox.widget {
			{
				widget,
				border_width = dpi(1),
				border_color = beautiful.groups_title_bg,
				widget = wibox.container.background
			},
			top = dpi(1),
			bottom = dpi(1),
			widget = wibox.container.margin
		}
	end

	s.systray = wibox.widget {
	    {
	        wibox.widget.systray(),
	        left   = 2,
	        top    = 2,
	        bottom = 2,
	        right  = 2,
	        widget = wibox.container.margin,
	    },
	    shape_clip = true,
	    widget     = wibox.container.background
	}

	s.search_apps			= build_widget(require('widget.search-apps')())
	s.volume			= build_widget(require('widget.volume')())
	s.end_session			= build_widget(require('widget.end-session')())
	s.layout_box			= build_widget(require('widget.layout-box')(s))
	s.clock				= build_widget(clock)

	panel : setup {
		{
			layout = wibox.layout.align.horizontal,
			expand = 'none',
			{
				layout = wibox.layout.fixed.horizontal,
				spacing = dpi(5),
				s.search_apps,
				build_widget(tag_list(s)),
				build_widget(task_list(s))
			},
			nil,
			{
				layout = wibox.layout.fixed.horizontal,
				spacing = dpi(5),
				{
					s.systray,
					margins = dpi(5),
					widget = wibox.container.margin
				},
				s.volume,
				s.layout_box,
				s.end_session,
				s.clock
			}
		},
		left = dpi(2),
		right = dpi(2),
		widget = wibox.container.margin
	}

	return panel
end

return panel
