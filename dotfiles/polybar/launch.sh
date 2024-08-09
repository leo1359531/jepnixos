#!/usr/bin/env bash

# Terminate already running bar instances
pkill polybar && polybar top 2>&1 | tee -a /tmp/polybar.log & disown

echo "Polybar launched..."
