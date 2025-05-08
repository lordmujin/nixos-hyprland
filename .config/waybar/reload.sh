#!/bin/sh

# Reload Waybar
killall .waybar-wrapped

waybar &
