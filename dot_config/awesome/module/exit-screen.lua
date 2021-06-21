local awful = require('awful')
local gears = require('gears')
local wibox = require('wibox')
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi
local apps = require('configuration.apps')
local clickable_container = require('widget.common').clickable_container

local build_button = function(icon, name)

	local button_text = wibox.widget {
		text = name,
		font = beautiful.font_bold_big,
		align = 'center',
		valign = 'center',
		widget = wibox.widget.textbox
	}

	local a_button = wibox.widget {
		{
			{
				{
					{
						image = icon,
						widget = wibox.widget.imagebox
					},
					margins = dpi(16),
					widget = wibox.container.margin
				},
				widget = wibox.container.background,
				shape = gears.shape.rectangle,
				shape_border_width = beautiful.border_width,
				border_color = beautiful.border_normal
			},
			forced_width = dpi(90),
			forced_height = dpi(90),
			widget = clickable_container
		},
		left = dpi(24),
		right = dpi(24),
		top = dpi(24),
		widget = wibox.container.margin
	}

	local build_a_button = wibox.widget {
		{
			layout = wibox.layout.fixed.vertical,
			spacing = dpi(12),
			a_button,
			button_text
		},
		widget = wibox.container.background,
		bg = beautiful.bg_normal,
	}

	return build_a_button
end

local quit_command = function()
	_G.awesome.quit()
end

local lock_command = function()
	_G.awesome.emit_signal('module::exit_screen_hide')
	awful.spawn.with_shell(apps.lock)
end

local poweroff_command = function()
	awful.spawn.with_shell(apps.poweroff)
	_G.awesome.emit_signal('module::exit_screen_hide')
end

local reboot_command = function()
	awful.spawn.with_shell(apps.reboot)
	_G.awesome.emit_signal('module::exit_screen_hide')
end

local poweroff = build_button(beautiful.poweroff, 'Poweroff')
poweroff:connect_signal(
	'button::release',
	function()
		poweroff_command()
	end
)

local reboot = build_button(beautiful.restart, 'Reboot')
reboot:connect_signal(
	'button::release',
	function()
		reboot_command()
	end
)

local exit = build_button(beautiful.logout, 'Quit')
exit:connect_signal(
	'button::release',
	function()
		quit_command()
	end
)

local lock = build_button(beautiful.lock, 'Lock')
lock:connect_signal(
	'button::release',
	function()
		lock_command()
	end
)

_G.screen.connect_signal(
	'request::desktop_decoration',
	function(s)

		s.exit_screen = wibox
		{
			screen = s,
			type = 'splash',
			visible = false,
			ontop = true,
			bg = beautiful.transparent,
			height = s.geometry.height,
			width = s.geometry.width,
			x = s.geometry.x,
			y = s.geometry.y
		}

		local exit_screen_grabber = awful.keygrabber {
			auto_start          = true,
			stop_event          = 'release',
			keypressed_callback = function(_, _, key, _)

				if key == 'q' then
					quit_command()

				elseif key == 'l' then
					lock_command()

				elseif key == 'p' then
					poweroff_command()

				elseif key == 'r' then
					reboot_command()

				elseif key == 'Escape' then
					_G.awesome.emit_signal('module::exit_screen_hide')
				end
			end
		}

		_G.awesome.connect_signal(
			'module::exit_screen_show',
			function()
				for sc in _G.screen do
					sc.exit_screen.visible = false
				end
				awful.screen.focused().exit_screen.visible = true
				exit_screen_grabber:start()
			end
		)

		_G.awesome.connect_signal(
			'module::exit_screen_hide',
			function()
				exit_screen_grabber:stop()
				for sc in _G.screen do
					sc.exit_screen.visible = false
				end
			end
		)

		s.exit_screen : buttons(
			gears.table.join(
				awful.button(
					{},
					2,
					function()
						_G.awesome.emit_signal('module::exit_screen_hide')
					end
				),
				awful.button(
					{},
					3,
					function()
						_G.awesome.emit_signal('module::exit_screen_hide')
					end
				)
			)
		)

		s.exit_screen : setup {
			layout = wibox.layout.align.vertical,
			expand = 'none',
			nil,
			{
				layout = wibox.layout.align.vertical,
				{
					layout = wibox.layout.align.horizontal,
					expand = 'none',
					nil,
					{
						{
							{
								poweroff,
								reboot,
								exit,
								lock,
								layout = wibox.layout.fixed.horizontal
							},
							spacing = dpi(30),
							layout = wibox.layout.fixed.vertical
						},
						widget = wibox.container.margin,
						margins = dpi(15)
					},
					nil
				}
			},
			nil
		}

	end
)
