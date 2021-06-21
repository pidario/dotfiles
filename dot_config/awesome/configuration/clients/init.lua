local awful = require('awful')
local beautiful = require('beautiful')
local ruled = require('ruled')
local client_buttons = require('configuration.clients.buttons')
local client_keys = require('configuration.clients.keys')

-- ░█▀▀░█░░░▀█▀░█▀▀░█▀█░▀█▀
-- ░█░░░█░░░░█░░█▀▀░█░█░░█░
-- ░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀░▀░░▀░

-- Signal function to execute when a new client appears.
_G.client.connect_signal(
	'manage',
	function(c)
		-- Set the windows at the slave,
		-- i.e. put it at the end of others instead of setting it master.
		if not _G.awesome.startup then
			awful.client.setslave(c)
		end

		if _G.awesome.startup and not c.size_hints.user_position and
			not c.size_hints.program_position then
			-- Prevent clients from being unreachable after screen count changes.
			awful.placement.no_offscreen(c)
		end
	end
)

-- Enable sloppy focus, so that focus follows mouse.
_G.client.connect_signal(
	'mouse::enter',
	function(c)
		c:emit_signal(
			'request::activate',
			'mouse_enter',
			{
				raise = true
			}
		)
	end
)

_G.client.connect_signal(
	'focus',
	function(c)
		c.border_color = beautiful.border_focus
	end
)

_G.client.connect_signal(
	'unfocus',
	function(c)
		c.border_color = beautiful.border_normal
	end
)

ruled.client.connect_signal(
	'request::rules',
	function()
		ruled.client.append_rule {
			id	   = 'all',
			rule	   = { },
			properties = {
				focus = awful.client.focus.filter,
				raise = true,
				buttons = client_buttons,
				keys = client_keys,
			}
		}
		ruled.client.append_rule {
			id	   = 'floating-clients',
			rule_any   = {
				type  = { 'dialog', 'utility' },
			},
			properties = {
				floating = true,
				above = true,
				raise = true,
				ontop = true,
				placement = awful.placement.centered
			}
		}
	end
)

local browsers_class = function (cls)
	if cls == "firefox" or cls == "librewolf" or cls == "Chromium" then
		return true
	end
	return false
end

-- TODO: This should be updated when the permission system is finished
_G.client.disconnect_signal("request::tag", awful.permissions.tag)
_G.client.connect_signal("request::tag", function(c, t, hints)
	if not _G.awesome.startup and (t and not hints) then
	--if t and not hints then
	-- If the client requested the tag change, ignore it.
	if browsers_class(c.class) then return end
	end
	awful.permissions.tag(c, t, hints)
end)
_G.client.disconnect_signal("request::geometry", awful.permissions.client_geometry_requests)
_G.client.connect_signal("request::geometry", function(c, context, hints)
	if context == "ewmh" and hints then
	-- If the client requested the geometry change, ignore it.
	if browsers_class(c.class) then return end
	end
	awful.permissions.client_geometry_requests(c, context, hints)
end)
