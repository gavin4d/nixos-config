#!/bin/sh
# cd /etc/nixos/modules/home-manager/desktop/wallpapers || exit
swww img -t grow --transition-duration 2 $1 || echo "Wall paper not found"
wallust -s -d /etc/nixos/modules/home-manager/desktop/wallust/ run $1 || exit
ags quit -i main-ags
ags run /etc/nixos/modules/home-manager/desktop/ags/app.ts &
