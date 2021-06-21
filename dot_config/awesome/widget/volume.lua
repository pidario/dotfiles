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
		text = '0',
		align = 'right',
		valign = 'center',
		visible = true,
		forced_width = 24,
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
			margins = beautiful.button_margin,
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

	local parse_mute = function(stdout)
		local out = split(stdout, '%s')
		local muted = out[1] == 'true'
		if muted then
			volume_icon_widget.image = beautiful.no_sound
			naughty.notification({
				app_name = 'Volume',
				icon = beautiful.no_sound,
				timeout = 5,
				title = '<b>Audio Muted</b>',
				message = 'Audio is muted!',
			})
		else
			volume_icon_widget.image = beautiful.sound
		end
	end

	local parse_volume = function(volume)
		volume_percentage_text:set_text(volume)
	end

	local get_volume = function()
		awful.spawn.easy_async(apps.audio_script .. ' get', parse_volume)
	end

	local volume_change = function(delta)
		awful.spawn.easy_async(apps.audio_script .. ' change ' .. delta, parse_volume)
	end

	local toggle_mute = function()
		awful.spawn.easy_async(apps.audio_script .. ' toggle-mute', parse_mute)
	end

	local get_mute = function()
		awful.spawn.easy_async(apps.audio_script .. ' get-mute', parse_mute)
	end

	volume_button:buttons(
		gears.table.join(
			awful.button(
				{},
				1,
				nil,
				function()
					awful.spawn(apps.audio_cp)
				end
			),
			awful.button(
				{},
				2,
				nil,
				function()
					toggle_mute()
				end
			),
			awful.button(
				{},
				3,
				nil,
				function()
					awful.spawn.easy_async(apps.audio_script .. ' next-sink', function(out)
						get_mute()
						get_volume()
						naughty.notification({
							app_name = 'Volume',
							icon = beautiful.sound,
							timeout = 5,
							title = '<b>Audio Sink Changed</b>',
							message = out,
						})
					end)
				end
			),
			awful.button(
				{},
				4,
				nil,
				function()
					volume_change(5)
				end
			),
			awful.button(
				{},
				5,
				nil,
				function()
					volume_change(-5)
				end
			)
		)
	)

	_G.awesome.connect_signal(
		'widget::volume::indecrease',
		function(delta)
			volume_change(delta)
		end
	)

	_G.awesome.connect_signal(
		'widget::volume::mute',
		function()
			toggle_mute()
		end
	)

	get_mute()
	get_volume()

	return volume_button
end

return button
