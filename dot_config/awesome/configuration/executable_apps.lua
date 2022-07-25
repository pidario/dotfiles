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
		wallpaper			= 'feh --bg-fill --no-fehbg --randomize /usr/share/backgrounds/*',

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

	}
}
