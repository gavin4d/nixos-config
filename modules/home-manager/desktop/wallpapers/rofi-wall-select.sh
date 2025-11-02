#!/bin/sh

WallDir=${1:-/etc/nixos/modules/home-manager/desktop/wallpapers/img}

PREVIEW=true \
rofi -show filebrowser -filebrowser-command '../change-wallpaper-img.sh' \
	-filebrowser-directory "$WallDir" \
	-filebrowser-sorting-method mtime \
	-selected-row 1 >/dev/null