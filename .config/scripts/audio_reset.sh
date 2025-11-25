#!/bin/bash
systemctl --user restart pipewire pipewire-pulse wireplumber
pkill -9 -f xdg-desktop-portal
pkill -9 -f xdg-desktop-portal-wlr
systemctl --user restart xdg-desktop-portal xdg-desktop-portal-wlr
