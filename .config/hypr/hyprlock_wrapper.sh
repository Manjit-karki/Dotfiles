#!/bin/bash

export XDG_RUNTIME_DIR=/run/user/$(id -u)

# Try to get the HYPRLAND_INSTANCE_SIGNATURE dynamically
export HYPRLAND_INSTANCE_SIGNATURE=$(ls /tmp/hypr | head -n 1)

exec /usr/bin/hyprlock
