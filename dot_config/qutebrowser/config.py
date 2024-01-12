startpage = 'https://searx.tiekoetter.com'

config.load_autoconfig(False)

c.auto_save.session = True
c.content.autoplay = False
c.confirm_quit = ['always']
c.content.cookies.accept = 'no-3rdparty'
c.content.headers.user_agent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}'
c.editor.command = ['st', '-e', 'vi', '{file}']
c.url.default_page = startpage
c.url.searchengines = {
    'DEFAULT': f'{startpage}/search?q={{}}'
}

config.set('content.cookies.accept', 'all', 'chrome-devtools://*')
config.set('content.cookies.accept', 'all', 'devtools://*')
