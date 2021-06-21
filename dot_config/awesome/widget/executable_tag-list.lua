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
	for i, o in ipairs(objects) do
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

		local text, bg, bg_image, _, args = label(o, tb)
		args = args or {}

		-- The text might be invalid, so use pcall.
		if text == nil or text == '' then
			tbm:set_margins(0)
		else
			if not tb:set_markup_silently(text) then
				tb:set_markup('<i>&lt;Invalid text&gt;</i>')
			end
		end
		bgb:set_bg(bg)
		if type(bg_image) == 'function' then
			-- TODO: Why does this pass nil as an argument?
			bg_image = bg_image(tb, o, nil, objects, i)
		end
		bgb:set_bgimage(bg_image)

		bgb.shape = args.shape
		bgb.shape_border_width = args.shape_border_width
		bgb.shape_border_color = args.shape_border_color

		w:add(bgb)
	end
end

local tag_list = function(s)
	return awful.widget.taglist(
		s,
		awful.widget.taglist.filter.all,
		awful.util.table.join(
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
		),
		{},
		list_update,
		wibox.layout.fixed.horizontal()
	)
end

return tag_list
