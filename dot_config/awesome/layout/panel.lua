local beautiful = require('beautiful')
local wibox = require('wibox')
local dpi = beautiful.xresources.apply_dpi
local panel = function(s)
	local custom_panel = wibox {
		ontop = true,
		screen = s,
		type = 'dock',
		height = beautiful.bp_height,
		width = s.geometry.width,
		x = s.geometry.x,
		y = 0,
		stretch = true,
	}

	custom_panel:struts {
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
			top = dpi(2),
			bottom = dpi(2),
			widget = wibox.container.margin
		}
	end

	s.systray = wibox.widget {
		{
			wibox.widget.systray(),
			left = 2,
			top = 2,
			bottom = 2,
			right = 2,
			widget = wibox.container.margin,
		},
		shape_clip = true,
		widget = wibox.container.background
	}

	local search_apps = build_widget(require('widget.search-apps')())
	local tag_list = build_widget(require('widget.tag-list')(s))
	local task_list = build_widget(require('widget.task-list')(s))
	local volume = build_widget(require('widget.volume')())
	local end_session = build_widget(require('widget.end-session')())
	local layout_box = build_widget(require('widget.layout-box')(s))
	local clock = build_widget(require('widget.clock')())
	local keyboard = build_widget(require('widget.keyboard')())

	custom_panel:setup {
		{
			layout = wibox.layout.align.horizontal,
			expand = 'none',
			{
				layout = wibox.layout.fixed.horizontal,
				spacing = dpi(0),
				search_apps,
				tag_list,
				task_list
			},
			nil,
			{
				layout = wibox.layout.fixed.horizontal,
				spacing = dpi(2),
				{
					s.systray,
					margins = dpi(2),
					widget = wibox.container.margin
				},
				volume,
				layout_box,
				keyboard,
				end_session,
				clock
			}
		},
		left = dpi(2),
		right = dpi(2),
		widget = wibox.container.margin
	}

	return custom_panel
end

return panel
