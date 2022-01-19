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

	local get_volume = function (cb)
		awful.spawn.easy_async(
			apps.default.mixer .. " --get-volume",
			function (stdout)
				cb(stdout)
			end
		)
	end

	local volume_change = function (delta, set)
		local param
		if set then
			param = " --set-volume " .. delta
		else
			if delta > 0 then
				param = " --increase " .. delta
			else
				param = " --decrease " .. (delta * -1)
			end
		end
		awful.spawn.easy_async(
			apps.default.mixer .. param,
			function ()
				get_volume(function (volume)
					volume_percentage_text:set_text(volume)
				end)
			end
		)
	end

	local get_mute = function ()
		awful.spawn.easy_async(
			apps.default.mixer .. " --get-mute",
			function(stdout)
				local out = split(stdout, '%s')
				local muted = out[1] == 'true'
				if muted then
					volume_icon_widget.image = beautiful.no_sound
					naughty.notification ({
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
		)
	end

	local toggle_mute = function()
		awful.spawn.easy_async(
			apps.default.mixer .. ' --toggle-mute',
			function ()
				get_mute()
			end
		)
	end

	volume_button:buttons(
		gears.table.join(
			awful.button(
				{},
				1,
				nil,
				function()
					awful.spawn(apps.default.audio_control_panel)
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
					volume_change(vol, true)
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
					volume_change(vol, true)
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
					volume_change(vol, true)
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

	awful.spawn.easy_async(
		-- trick to start audio server, otherwise functions inside callback will fail
		apps.default.mixer .. " --list-sinks",
		function ()
			get_mute()
			get_volume(function (volume)
				volume_percentage_text:set_text(volume)
			end)
		end
	)

	return volume_button
end

return button
