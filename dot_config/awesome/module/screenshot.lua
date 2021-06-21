local naughty = require('naughty')
local awful = require('awful')
local apps = require('configuration.apps')
local home = os.getenv('HOME')

local shot = function(mode)
	local file_loc = home .. '/' .. os.date('%Y-%m-%dT%H%M%S') .. '.png'
	local select = ''

	if (mode == 'area') then
		select = '--select'
	end

	local cmd = apps.screenshot .. ' ' .. select .. ' ' .. file_loc
	awful.spawn.easy_async(cmd, function()
		local clip_cmd = apps.clipboard .. ' -t image/png -i ' .. file_loc
		-- it cannot be a single command with pipe because xclip hangs
		-- so the notification would be shown once this xclip process exit:
		-- that is when another object is set in the clipboard itself
		awful.spawn.easy_async(clip_cmd)
		local open_image = naughty.action {
			name = 'Open',
			icon_only = false,
		}
		local open_folder = naughty.action {
			name = 'Open Folder',
			icon_only = false,
		}

		local delete_image = naughty.action {
			name = 'Delete',
			icon_only = false,
		}

		open_image:connect_signal('invoked', function()
			awful.spawn(apps.image_viewer .. ' ' .. file_loc, false)
		end)

		open_folder:connect_signal('invoked', function()
			awful.spawn(apps.file_manager .. ' ' .. home, false)
		end)

		delete_image:connect_signal('invoked', function()
			awful.spawn(apps.trash .. ' ' .. file_loc, false)
		end)

		naughty.notification ({
			app_name = 'Screenshot Tool',
			icon = file_loc,
			timeout = 10,
			title = '<b>Snap!</b>',
			message = 'Screenshot saved in ' .. file_loc .. ' and copied to clipboard',
			actions = { open_image, open_folder, delete_image }
		})
	end)

end

return shot
