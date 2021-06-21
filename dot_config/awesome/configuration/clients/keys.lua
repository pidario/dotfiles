local awful = require('awful')
local mod = require('configuration.keys.mod')
local modkey = mod.mod_key

local client_keys = awful.util.table.join(
	awful.key(
		{modkey},
		'f',
		function(c)
			c.fullscreen = not c.fullscreen
			c:raise()
		end,
		{description = 'toggle fullscreen', group = 'client'}
	),
	awful.key(
		{modkey},
		'q',
		function(c)
			c:kill()
		end,
		{description = 'close', group = 'client'}
	),
	awful.key(
		{'Control', modkey},
		'Left',
		function()
			awful.client.focus.byidx(-1)
		end,
		{description = 'change focus by index', group = 'client'}
	),
	awful.key(
		{'Control', modkey},
		'Right',
		function()
			awful.client.focus.byidx(1)
		end,
		{description = 'change focus by index', group = 'client'}
	),
	awful.key(
		{modkey},
		'u',
		awful.client.urgent.jumpto,
		{description = 'jump to urgent client', group = 'client'}
	),
	awful.key(
		{modkey},
		'Tab',
		function()
			awful.client.focus.history.previous()
			if _G.client.focus then
				_G.client.focus:raise()
			end
		end,
		{description = 'go back', group = 'client'}
	),
	awful.key(
		{modkey},
		'm',
		function(c)
			c.minimized = true
		end,
		{description = 'minimize client', group = 'client'}
	),
	awful.key(
		{modkey},
		'c',
		function(c)
			c.fullscreen = false
			c.maximized = false
			c.floating = not c.floating
			c:raise()
		end,
		{description = 'toggle floating', group = 'client'}
	)
)

return client_keys
