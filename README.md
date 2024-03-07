In order to fully use these dotfiles, some configuration is needed in `~/.config/chezmoi/chezmoi.toml`:

```toml
[data.config]
name = "John Doe"
email = "john@doe.com"
pgp_key = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
pgp_key_3 = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
maildir = "/path/to/mail"
email_2 = "doe@john.com"
email_3 = "doe@bob.org"
user_3 = "doe@bob.org"
imap_host_3 = "imap.example.org"
imap_port_3 = 143
smtp_host_3 = "smtp.example.org"
smtp_port_3 = 25
mailboxes = "=MAILBOX =MAILBOX2"
virtual_mailboxes = "\"VM\" \"notmuch://?query=path:XXX/**"
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
passcmd_3 = "XXX"
atuin_server = "https://my-atuin-server.com"
git_name = "johndoe"
git_mail = "git@johndoe.org"
git_work_path = "~/workpath/**"
git_work_conf = "~/.config/git/work"
```
