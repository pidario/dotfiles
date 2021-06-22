local awful = require('awful')
local wibox = require('wibox')
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi
local gears = require('gears')
local common = require('widget.common')
local clickable_container = common.clickable_container
local create_buttons = common.create_buttons

local function list_update(w, buttons, label, data, objects)
	-- update the widgets, creating them if needed
	w:reset()
	for _, o in ipairs(objects) do
		local cache = data[o]
		local ib, tb, bgb, ibm, tt, l, ll, bg_clickable
		if cache then
			ib = cache.ib
			tb = cache.tb
			bgb = cache.bgb
			ibm = cache.ibm
			tt  = cache.tt
		else
			ib = wibox.widget.imagebox()
			tb = wibox.widget.textbox()
			tb.forced_width = 100
			bg_clickable = clickable_container()
			bgb = wibox.container.background()
			ibm = wibox.widget {
				ib,
				left = dpi(4),
				right = dpi(4),
				top = dpi(4),
				bottom = dpi(4),
				widget = wibox.container.margin
			}
			l = wibox.layout.fixed.horizontal()
			ll = wibox.layout.fixed.horizontal()
			-- All of this is added in a fixed widget
			l:fill_space(true)
			l:add(ibm)
			l:add(tb)
			ll:add(l)
			bg_clickable:set_widget(ll)
			bgb:set_widget(bg_clickable)
			l:buttons(create_buttons(buttons, o))
			tt = awful.tooltip({
				objects = {bgb},
				mode = 'mouse',
				align = 'bottom',
				delay_show = 0.5,
			})
			data[o] = {
				ib = ib,
				tb = tb,
				bgb = bgb,
				ibm = ibm,
				tt  = tt
			}
		end
		local text, bg, _, icon = label(o, tb)
		local text_only = text:match('>(.-)<')
		tt:set_text(gears.string.xml_unescape(text_only))
		tt:add_to_object(tb)
		if not tb:set_markup_silently(text) then
			tb:set_text(text_only)
		end
		bgb:set_bg(bg)
		if icon then
			ib.image = gears.surface(icon)
		end

		w:add(bgb)
	end
end

local tasklist_buttons = awful.util.table.join(
	awful.button(
		{},
		1,
		function(c)
			if c == _G.client.focus then
				c.minimized = true
			else
				-- Without this, the following
				-- :isvisible() makes no sense
				c.minimized = false
				if not c:isvisible() and c.first_tag then
					c.first_tag:view_only()
				end
				-- This will also un-minimize
				-- the client, if needed
				_G.client.focus = c
				c:raise()
			end
		end
	),
	awful.button(
		{},
		4,
		function()
			awful.client.focus.byidx(-1)
		end
	),
	awful.button(
		{},
		5,
		function()
			awful.client.focus.byidx(1)
		end
	)
)

local task_list = function(s)
	return awful.widget.tasklist {
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = tasklist_buttons,
		update_function = list_update
	}
end

return task_list
