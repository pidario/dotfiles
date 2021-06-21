return {
	terminal	= 'st',
	web_browser	= 'firefox -P',
	file_manager	= 'pcmanfm-qt',
	clipboard	= 'xclip -selection clipboard',
	trash		= 'gio trash',
	wallpaper	= 'feh --bg-fill --no-fehbg --randomize /usr/share/backgrounds/*',
	lock		= 'physlock -m',
	launcher	= 'rofi -show combi -combi-modi "drun,ssh,window,run" -modi combi -show-icons -theme dmenu -display-drun "" -display-ssh "" -display-window "" -display-run ">" -theme-str \'#prompt {enabled: false;}\'',
	image_viewer	= 'xdg-open',
	screenshot	= 'maim --hidecursor --nokeyboard',
	audio_script	= 'volume',
	audio_cp	= 'pavucontrol',
	media_player	= 'mpc',
	calculator	= 'qalculate-gtk',
	reboot		= 'reboot',
	poweroff	= 'poweroff',
}
