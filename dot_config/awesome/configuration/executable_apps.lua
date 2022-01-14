local wall_dir = '/usr/share/backgrounds'

return {

	-- The default applications that we will use in keybindings and widgets
	default = {

		-- Terminal Emulator
		terminal			= 'st',

		-- Web browser
		web_browser			= 'firefox -P',

		-- GUI File manager
		file_manager			= 'pcmanfm',

		-- Wallpaper setter
		wallpaper			= 'feh --bg-fill --no-fehbg --randomize ' .. wall_dir .. '/*',

		-- Lockscreen
		lock				= 'i3lock --color 000000',

		-- Application Menu
		rofi_appmenu			= 'rofi -show drun -show-icons -theme dmenu -theme-str \'#prompt {enabled: false;}\'',

		-- Image Viewer
		image_viewer			= 'feh',

		-- Mixer
		mixer				= 'pamixer',

		-- Calculator
		calculator			= 'qalculate-gtk'

	},

	-- List of apps to run on start-up
	-- auto-start.lua module will start these

	run_on_start_up = {

		-- VMWare
		'vmware-user',

		-- NumLockX
		'numlockx',

		-- Imwheel
		'imwheel --detach',

		-- Polkitd agent
		"/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1",

	}

}
