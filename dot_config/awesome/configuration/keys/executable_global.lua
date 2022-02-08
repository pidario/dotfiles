local awful = require('awful')
local apps = require('configuration.apps')
local set_wallpaper = require('module.wallpaper').set
local shot = require('module.screenshot')
local hotkeys_popup = require('awful.hotkeys_popup').widget
local mod = require('configuration.keys.mod')
local modkey = mod.mod_key
local altkey = mod.alt_key

local globalKeys = awful.util.table.join(

	-- Hotkeys
	awful.key(
		{modkey},
		'F1',
		hotkeys_popup.show_help,
		{description = 'show help', group = 'utility'}
	),
	awful.key(
		{modkey},
		'w',
		set_wallpaper,
		{description = 'cycle wallpaper', group = 'utility'}
	),
	awful.key({altkey},
		'r',
		_G.awesome.restart,
		{description = 'reload awesome', group = 'utility'}
	),

	awful.key({modkey, 'Shift'},
		'q',
		_G.awesome.quit,
		{description = 'quit awesome', group = 'utility'}
	),
	awful.key(
		{modkey},
		'Left',
		awful.tag.viewprev,
		{description = 'previous/next tag', group = 'tag'}
	),
	awful.key(
		{modkey},
		'Right',
		awful.tag.viewnext,
		{description = 'previous/next tag', group = 'tag'}
	),
	awful.key(
		{modkey},
		'Escape',
		awful.tag.history.restore,
		{description = 'alternate between current and previous tag', group = 'tag'}
	),
	awful.key({ modkey, 'Shift' },
		'Left',
		function ()
			local focused = awful.screen.focused()
			for _ = 1, #focused.tags do
				awful.tag.viewidx(-1, focused)
				if #focused.clients > 0 then
					return
				end
			end
		end,
		{description = 'previous/next non-empty tag', group = 'tag'}
	),
	awful.key({ modkey, 'Shift' },
		'Right',
		function ()
			local focused =  awful.screen.focused()
			for _ = 1, #focused.tags do
				awful.tag.viewidx(1, focused)
				if #focused.clients > 0 then
					return
				end
			end
		end,
		{description = 'previous/next non-empty tag', group = 'tag'}
	),
	awful.key(
		{modkey, 'Shift'},
		'F1',
		function()
			awful.screen.focus_relative(-1)
		end,
		{ description = 'previous/next screen', group = 'utility'}
	),
	awful.key(
		{modkey, 'Shift'},
		'F2',
		function()
			awful.screen.focus_relative(1)
		end,
		{ description = 'previous/next screen', group = 'utility'}
	),
	awful.key(
		{modkey, 'Shift'},
		'm',
		function()
			local c = awful.client.restore()
			-- Focus restored client
			if c then
				_G.client.focus = c
				c:raise()
			end
		end,
		{description = 'restore minimized', group = 'client'}
	),
	awful.key(
		{altkey, 'Control'},
		'Left',
		function()
			awful.tag.incmwfact(-0.05)
		end,
		{description = 'master width factor', group = 'client'}
	),
	awful.key(
		{altkey, 'Control'},
		'Right',
		function()
			awful.tag.incmwfact(0.05)
		end,
		{description = 'master width factor', group = 'client'}
	),
	awful.key(
		{},
		'XF86Calculator',
		function()
			awful.spawn(apps.default.calculator)
		end,
		{description = 'calculator', group = 'hotkeys'}
	),
	awful.key(
		{},
		'XF86AudioRaiseVolume',
		function()
			_G.awesome.emit_signal('widget::volume::indecrease', 5)
		end,
		{description = '+/- volume', group = 'hotkeys'}
	),
	awful.key(
		{},
		'XF86AudioLowerVolume',
		function()
			_G.awesome.emit_signal('widget::volume::indecrease', -5)
		end,
		{description = '+/- volume', group = 'hotkeys'}
	),
	awful.key(
		{},
		'XF86AudioMute',
		function()
			_G.awesome.emit_signal('widget::volume::mute')
		end,
		{description = 'toggle mute', group = 'hotkeys'}
	),
	awful.key(
		{},
		'XF86AudioPrev',
		function()
			awful.spawn('mpc prev', false)
		end,
		{description = 'previous/next', group = 'hotkeys'}
	),
	awful.key(
		{},
		'XF86AudioNext',
		function()
			awful.spawn('mpc next', false)
		end,
		{description = 'previous/next', group = 'hotkeys'}
	),
	awful.key(
		{},
		'XF86AudioPlay',
		function()
			awful.spawn('mpc toggle', false)
		end,
		{description = 'play/pause music', group = 'hotkeys'}

	),
	awful.key(
		{},
		'XF86AudioStop',
		function()
			awful.spawn('mpc stop', false)
		end,
		{description = 'stop music', group = 'hotkeys'}

	),
	awful.key(
		{altkey},
		'q',
		function()
			_G.awesome.emit_signal('module::exit_screen_show')
		end,
		{description = 'toggle exit screen', group = 'utility'}
	),
	awful.key(
		{},
		'Print',
		function ()
			shot("full")
		end,
		{description = 'fullscreen screenshot', group = 'hotkeys'}
	),
	awful.key(
		{modkey},
		's',
		function ()
			shot('area')
		end,
		{description = 'area/selected screenshot', group = 'utility'}
	),
	awful.key(
		{modkey, 'Shift'},
		'l',
		function()
			awful.spawn(apps.default.lock, false)
		end,
		{description = 'lock the screen', group = 'utility'}
	),
	awful.key(
		{modkey},
		'Return',
		function()
			awful.spawn(apps.default.terminal)
		end,
		{description = 'open default terminal', group = 'launcher'}
	),
	awful.key(
		{modkey},
		'e',
		function()
			awful.spawn(apps.default.file_manager)
		end,
		{description = 'open default file manager', group = 'launcher'}
	),
	awful.key(
		{modkey},
		'b',
		function()
			awful.spawn(apps.default.web_browser)
		end,
		{description = 'open default web browser', group = 'launcher'}
	),
	awful.key(
		{modkey},
		'space',
		function()
			awful.spawn(apps.default.launcher, false)
		end,
		{description = 'open application drawer', group = 'launcher'}
	),
	awful.key(
		{},
		'Menu',
		function()
			awful.spawn(apps.default.launcher, false)
		end,
		{description = 'open application drawer', group = 'hotkeys'}
	)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
	-- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
	local descr_view, descr_toggle, descr_move
	if i == 1 or i == 9 then
		descr_view = {description = 'view tag #', group = 'tag'}
		descr_toggle = {description = 'toggle tag #', group = 'tag'}
		descr_move = {description = 'move focused client to tag #', group = 'tag'}
	end
	globalKeys =
		awful.util.table.join(
		globalKeys,
		-- View tag only.
		awful.key(
			{modkey},
			'#' .. i + 9,
			function()
				local focused = awful.screen.focused()
				local tag = focused.tags[i]
				if tag then
					tag:view_only()
				end
			end,
			descr_view
		),
		-- Toggle tag display.
		awful.key(
			{modkey, 'Control'},
			'#' .. i + 9,
			function()
				local focused = awful.screen.focused()
				local tag = focused.tags[i]
				if tag then
					awful.tag.viewtoggle(tag)
				end
			end,
			descr_toggle
		),
		-- Move client to tag.
		awful.key(
			{modkey, 'Shift'},
			'#' .. i + 9,
			function()
				if _G.client.focus then
					local tag = _G.client.focus.screen.tags[i]
					if tag then
						_G.client.focus:move_to_tag(tag)
					end
				end
			end,
			descr_move
		)
	)
end

_G.root.keys(globalKeys)
