In order to fully use these dotfiles, some configuration is needed in `~/.config/chezmoi/chezmoi.toml`:

```toml
[data.config]
name = "John Doe"
email = "john@doe.com"
pgp_key = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
pgp_key_2 = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
maildir = "/path/to/mail"
email_2 = "doe@bob.org"
user_2 = "doe@bob.org"
imap_host_2 = "imap.example.org"
imap_port_2 = 143
smtp_host_2 = "smtp.example.org"
smtp_port_2 = 25
mailboxes = "=MAILBOX =MAILBOX2"
virtual_mailboxes = "\"VM\" \"notmuch://?query=path:XXX/**"
mailboxes_2 = "=MAILBOX"
patterns_skip = "!\"[Gmail]/All Mail\""
oauth2_client_id = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx.apps.googleusercontent.com"
oauth2_client_secret = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
dav_server = "https://my-dav-server.com"
dav_key = "/path/to/key.pem"
dav_cert = "/path/to/cert.pem"
personal_contacts_collection = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
work_contacts_collection = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
contacts_collection = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
calendars_collection = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
passcmd_2 = "XXX"
atuin_server = "https://my-atuin-server.com"
git_name = "johndoe"
git_mail = "git@johndoe.org"
git_sign_key = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
git_work_path = "~/workpath/**"
git_work_conf = "~/.config/git/work"
loc_lat = 35.6821936
loc_lon = 139.7622210
[[data.config.monitors]]
name = "HDMI-A-1"
resolution = "1920x1080"
refresh = 60
position = "0x0"
scale = 1
[data.audio]
vmOptimization = false
virtualMic = true
```
