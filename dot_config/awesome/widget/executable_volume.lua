local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local naughty = require('naughty')
local apps = require('configuration.apps')
local clickable_container = require('widget.common').clickable_container
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi

local button = function()

	local volume_icon_widget = wibox.widget {
		id = 'icon',
		image = beautiful.sound,
		widget = wibox.widget.imagebox,
		resize = true
	}

	local volume_imagebox = wibox.widget {
		nil,
		volume_icon_widget,
		nil,
		expand = 'none',
		layout = wibox.layout.align.vertical
	}

	local volume_percentage_text = wibox.widget {
		id = 'percent_text',
		text = '',
		align = 'center',
		valign = 'center',
		visible = true,
		widget = wibox.widget.textbox
	}

	local volume_widget = wibox.widget {
		layout = wibox.layout.fixed.horizontal,
		spacing = dpi(5),
		volume_imagebox,
		volume_percentage_text
	}

	local volume_button = wibox.widget {
		{
			volume_widget,
			margins = dpi(5),
			widget = wibox.container.margin
		},
		widget = clickable_container
	}

	local split = function(s, delimiter)
		local result = {};
		for match in (s .. delimiter):gmatch("(.-)" .. delimiter) do
			table.insert(result, match);
		end
		return result;
	end

	local set_volume = function()
		awful.spawn.easy_async(
			apps.default.mixer .. " --get-mute --get-volume",
			function(stdout)
				local out = split(stdout, '%s')
				volume_percentage_text:set_text(out[2])
				local muted = out[1] == 'true'
				if muted then
					volume_icon_widget.image = beautiful.no_sound
					naughty.notification ({
						app_name = 'Volume',
						icon = beautiful.no_sound,
						timeout = 5,
						title = '<b>Audio Muted!</b>',
						message = 'Audio is muted',
					})
				else
					volume_icon_widget.image = beautiful.sound
				end
			end
		)
	end

	-- The emit will come from the global keybind
	_G.awesome.connect_signal(
		'widget::volume',
		function()
			set_volume()
		end
	)

	local set_volume_perc_text = function(value)
		awful.spawn(apps.default.mixer .. ' --set-volume ' .. value, false)
		volume_percentage_text:set_text(value)
	end

	set_volume()

	volume_button:buttons(
		gears.table.join(
			awful.button(
				{},
				2,
				nil,
				function()
					awful.spawn.easy_async(
						apps.default.mixer .. ' --toggle-mute',
						function()
							set_volume()
						end
					)
				end
			),
			awful.button(
				{},
				3,
				nil,
				function()
					local curr_value = tonumber(volume_percentage_text.text)
					local vol
					if curr_value >= 0 and curr_value < 25 then
						vol = 25
					elseif curr_value >= 25 and curr_value < 50 then
						vol = 50
					elseif curr_value >= 50 and curr_value < 75 then
						vol = 75
					elseif curr_value >= 75 and curr_value < 100 then
						vol = 100
					else
						vol = 0
					end
					set_volume_perc_text(vol)
				end
			),
			awful.button(
				{},
				4,
				nil,
				function()
					local vol
					local curr_value = tonumber(volume_percentage_text.text)
					if curr_value >= 95 then
						vol = 100
					else
						vol = curr_value + 5
					end
					set_volume_perc_text(vol)
				end
			),
			awful.button(
				{},
				5,
				nil,
				function()
					local vol
					local curr_value = tonumber(volume_percentage_text.text)
					if curr_value <= 5 then
						vol = 0
					else
						vol = curr_value - 5
					end
					set_volume_perc_text(vol)
				end
			)
		)
	)

	return volume_button
end

return button
