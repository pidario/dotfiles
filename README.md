In order to fully use these dotfiles, some configuration is needed in `~/.config/chezmoi/chezmoi.toml`:

```toml
[data.config]
name = "John Doe"
email = "john@doe.com"
pgp_key = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
maildir = "/path/to/mail"
email_2 = "doe@john.com"
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
```
