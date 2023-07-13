In order to fully use these dotfiles, some environment variables are needed:

* MY_NAME
used by neomutt and notmuch

* MY_EMAIL
used by neomutt isync msmtp and notmuch

* MY_EMAIL_2
used by neomutt isync msmtp and notmuch (second account)

* MY_EMAIL_SKIP_PATTERNS
optional, used by isync to skip certain mailboxes
with the following value, isync won't synchronize "All Mail" and "Spam" mailboxes:
```sh
export MY_EMAIL_SKIP_PATTERNS='!"[Gmail]/All Mail" !"[Gmail]/Spam"'
```

* MY_EMAIL_PGP_KEY
used by neomutt to sign outgoing emails

* MY_EMAIL_MAILBOXES and MY_EMAIL_VMAILBOXES
optional, used by neomutt to add other mailboxes or virtual mailboxes to sidebar
```sh
export MY_EMAIL_MAILBOXES="=folder1 =folder2/subfolder1 =folder2/subfolder2"
export MY_EMAIL_VMAILBOXES='"VM1" "notmuch://?query=to:mailing-list@example.com"'
```

* MY_EMAIL_OAUTH2_CLIENT_ID and MY_EMAIL_OAUTH2_CLIENT_SECRET
used by oauth2token to obtain the access token

* MY_DAV_SERVER
used by vdirsyncer

* MY_DAV_CERT_PATH and MY_DAV_KEY_PATH
used by vdirsyncer, absolute paths to certificate and key used for mutual authentication to dav server

