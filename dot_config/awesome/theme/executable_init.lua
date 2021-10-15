local dpi = require('beautiful').xresources.apply_dpi
local icons_dir = require('gears').filesystem.get_configuration_dir() .. 'theme/icons/'
-- Colorscheme
local system_black_dark = '#383C4A'
local system_black_light = '#56687E'
local system_red_dark = '#EE4F84'
local system_green_dark = '#53E2AE'
local system_yellow_dark = '#F1FF52'
local system_blue_dark = '#5294E2'
local system_white = '#FFFFFF'

local theme = {}

theme.bp_height = dpi(26)
theme.button_margin = dpi(3)
-- Font
theme.font = 'Noto Regular 10'
theme.font_bold = 'Noto Bold 10'
theme.font_bold_big = 'Noto Bold 12'
theme.font_bold_huge = 'Noto Bold 32'

theme.primary = system_blue_dark
theme.secondary = system_yellow_dark
theme.red = system_red_dark
theme.green = system_green_dark
theme.blue = system_blue_dark
theme.yellow = system_yellow_dark
theme.transparent = '#00000095'

theme.bg_normal = system_black_dark
theme.border_width = dpi(1)
theme.border_normal = system_white
theme.border_focus = theme.primary
theme.border_marked = theme.secondary

-- UI Groups
theme.groups_title_bg = system_black_light
-- UI events
theme.press_event = system_black_light
-- Decorations
theme.useless_gap = dpi(2)
-- Icons (Volume icons by Freepik: https://www.flaticon.com/authors/freepik)
theme.sound = icons_dir .. 'sound.svg'
theme.no_sound = icons_dir .. 'no-sound.svg'
theme.awesome_icon = icons_dir .. 'awesome.svg'
theme.poweroff = icons_dir .. 'power.svg'
theme.restart = icons_dir .. 'restart.svg'
theme.logout = icons_dir .. 'logout.svg'
theme.lock = icons_dir .. 'lock.svg'
theme.layout_max = icons_dir .. 'max.svg'
theme.layout_tile = icons_dir .. 'tile.svg'
theme.layout_dwindle = icons_dir .. 'dwindle.svg'
theme.layout_floating = icons_dir .. 'floating.svg'
-- Taglist
theme.taglist_bg_empty = system_black_dark
theme.taglist_bg_occupied = system_black_light
theme.taglist_fg_occupied = system_white
theme.taglist_bg_urgent = theme.secondary
theme.taglist_fg_urgent = system_black_dark
theme.taglist_bg_focus = theme.primary
theme.taglist_fg_focus = system_black_dark
theme.taglist_spacing = dpi(0)
-- Tasklist
theme.tasklist_bg_normal = system_black_light
theme.tasklist_bg_focus = theme.primary
theme.tasklist_bg_urgent = theme.secondary
theme.tasklist_bg_minimize = system_black_dark
theme.tasklist_fg_normal = system_white
theme.tasklist_fg_focus = system_black_dark
theme.tasklist_fg_focus = system_black_dark
theme.tasklist_fg_urgent = system_black_dark
theme.tasklist_fg_minimize = system_white
-- Notification
theme.notification_position = 'top_right'
theme.notification_bg = system_black_dark
theme.notification_margin = dpi(5)
theme.notification_border_width = dpi(1)
theme.notification_border_color = theme.primary
theme.notification_spacing = dpi(5)
theme.notification_icon_resize_strategy = 'center'
theme.notification_icon_size = dpi(32)
-- Hotkey popup
theme.hotkeys_font = theme.font_bold
theme.hotkeys_description_font = theme.font
theme.hotkeys_bg = system_black_dark
theme.hotkeys_group_margin = dpi(20)
theme.hotkeys_modifiers_fg = theme.primary
theme.hotkeys_border_color = theme.primary

return theme

