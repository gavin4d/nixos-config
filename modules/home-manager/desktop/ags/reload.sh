#!/bin/sh
ags -q
sassc /etc/nixos/modules/home-manager/desktop/ags/scss/main.scss /etc/nixos/modules/home-manager/desktop/ags/style.css
home-manager switch --flake /etc/nixos#gavin4d
ags
