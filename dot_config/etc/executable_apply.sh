#!/bin/sh

set -eu

[ "$(id -u)" -ne 0 ] && exec sudo -- "$0" "$@"

SOURCE="$(dirname "$(dirname "$(realpath "$0")")")"

echo "source directory: $SOURCE"

FIREFOX_PATH=/etc/firefox/policies
CHROMIUM_PATH=/etc/chromium/policies/managed
SDDM_PATH=/etc/sddm.conf.d

mkdir -p "$FIREFOX_PATH" "$CHROMIUM_PATH" "$SDDM_PATH"

cp "$SOURCE$FIREFOX_PATH/"* "$FIREFOX_PATH/"
cp "$SOURCE$CHROMIUM_PATH/"* "$CHROMIUM_PATH/"
cp "$SOURCE$SDDM_PATH/"* "$SDDM_PATH/"

echo "done"
