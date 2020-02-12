#!/usr/bin/env bash

#Requirements
#1. `wmctrl` command to make the ssr's window active
#2. `xdotool` command to simulate a key event
#3. Change the value of `key_to_pause_recording` variable below.

#Usage
# recording_timer <minutes>
# recording_timer <minutes> <seconds>

set -e

key_to_pause_recording="super+z" #This is the hotkey set in SimpleScreenRecorder.

usage_string="\
Usage:
  recording_timer <minute>
  recording_timer <minute> <second>
  recording_timer <hour> <minute> <second>

Options:
  -h,--help:    show this help\
"

if (( $# == 0 )) || (( $# > 3 )); then
    echo "${usage_string}"
    exit 1
elif [[ $1 == "-h" || $1 == "--help" ]]; then
    echo "${usage_string}"
    exit 0
fi

sleep_length=0
if [[ $# == 1 ]]; then
    echo "Timer is set for $1 minutes."
    sleep_length=$(( $1 * 60 ))
elif [[ $# == 2 ]]; then
    echo "Timer is set for $1 minutes $2 seconds."
    sleep_length=$(( $1 * 60 + $2 ))
else
    echo "Timer is set for $1 hours $2 minutes $3 seconds."
    sleep_length=$(( $1 * 3600 + $2 * 60 + $3 ))
fi

sleep ${sleep_length}
wmctrl -F -a "SimpleScreenRecorder"
sleep 1 #Wait until the activation is done.
xdotool key ${key_to_pause_recording}
echo "Recording has successfully been paused."

