#!/bin/bash

APP_PATH="$HOME/.TacOS_Stuff/end_session_dialog/end_session_dialog.py"
if pgrep -f "$APP_PATH" > /dev/null; then
    pkill -f "$APP_PATH"
else
    python3 "$APP_PATH" &
fi