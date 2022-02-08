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

		-- Application Launcher
		launcher			= 'rofi -show combi -combi-modi "drun,ssh,window,run" -modi combi -show-icons -theme dmenu -display-drun "" -display-ssh "" -display-window "" -display-run ">" -theme-str \'#prompt {enabled: false;}\'',

		-- Image Viewer
		image_viewer			= 'feh',

		-- Audio
		mixer				= 'pamixer',
		audio_control_panel		= 'pavucontrol',

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
