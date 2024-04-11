#!/bin/sh
ags -q
sassc ./scss/main.scss ./style.css
home-manager switch --flake /etc/nixos#gavin
ags
