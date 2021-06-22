local awful = require('awful')
local wibox = require('wibox')
local dpi = require('beautiful').xresources.apply_dpi
local common = require('widget.common')
local clickable_container = common.clickable_container
local create_buttons = common.create_buttons
local modkey = require('configuration.keys.mod').mod_key

local function list_update(w, buttons, label, data, objects)
	-- update the widgets, creating them if needed
	w:reset()
	for _, o in ipairs(objects) do
		local cache = data[o]
		local tb, bgb, tbm, l, bg_clickable
		if cache then
			tb = cache.tb
			bgb = cache.bgb
			tbm = cache.tbm
		else
			tb = wibox.widget.textbox()
			bgb = wibox.container.background()
			tbm = wibox.widget {
				tb,
				left = dpi(8),
				right = dpi(8),
				widget = wibox.container.margin
			}
			l = wibox.layout.fixed.horizontal()
			bg_clickable = clickable_container()
			-- All of this is added in a fixed widget
			l:fill_space(true)
			l:add(tbm)
			bg_clickable:set_widget(l)
			-- And all of this gets a background
			bgb:set_widget(bg_clickable)
			bgb:buttons(create_buttons(buttons, o))
			data[o] = {
				tb = tb,
				bgb = bgb,
				tbm = tbm
			}
		end
		local text, bg = label(o, tb)
		if not tb:set_markup_silently(text) then
			tb:set_text(text)
		end
		bgb:set_bg(bg)
		w:add(bgb)
	end
end

local taglist_buttons = awful.util.table.join(
	awful.button(
		{},
		1,
		function(t)
			t:view_only()
		end
	),
	awful.button(
		{modkey},
		1,
		function(t)
			if _G.client.focus then
				_G.client.focus:move_to_tag(t)
				t:view_only()
			end
		end
	),
	awful.button({}, 3, awful.tag.viewtoggle),
	awful.button(
		{modkey},
		3,
		function(t)
			if _G.client.focus then
				_G.client.focus:toggle_tag(t)
			end
		end
	),
	awful.button(
		{},
		4,
		function(t)
			awful.tag.viewprev(t.screen)
		end
	),
	awful.button(
		{},
		5,
		function(t)
			awful.tag.viewnext(t.screen)
		end
	)
)

local tag_list = function(s)
	return awful.widget.taglist {
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = taglist_buttons,
		update_function = list_update

	}
end

return tag_list
