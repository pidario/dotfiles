#!/bin/sh

set -eu

if [ "$(id -u)" -ne 0 ]; then
	echo "this script must be run as root"
	exit 1
fi

SOURCE="$(dirname "$(dirname "$(realpath "$0")")")"

echo "source directory: $SOURCE"

FIREFOX_PATH=/etc/firefox/policies
CHROMIUM_PATH=/etc/chromium/policies/managed

mkdir -p "$FIREFOX_PATH" "$CHROMIUM_PATH"

cp "$SOURCE$FIREFOX_PATH/"* "$FIREFOX_PATH/"
cp "$SOURCE$CHROMIUM_PATH/"* "$CHROMIUM_PATH/"

echo "done"
