local beautiful = require('beautiful')
require('awful.autofocus')
beautiful.init(require('theme'))
require('layout')
require('configuration.clients')
require('configuration.tags')
require('configuration.keys.global')
require('module.notifications')
require('module.auto-start')
require('module.exit-screen')
require('module.wallpaper').timer()
