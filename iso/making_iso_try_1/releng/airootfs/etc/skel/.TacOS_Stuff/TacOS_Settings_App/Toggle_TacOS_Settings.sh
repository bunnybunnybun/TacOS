#!/bin/bash

APP_PATH="/usr/local/bin/TacOS_Settings"
if pgrep -f "$APP_PATH" > /dev/null; then
    pkill -f "$APP_PATH"
else
    TacOS_Settings
fi