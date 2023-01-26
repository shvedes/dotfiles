#!/usr/bin/env bash

var=" $(xset -q | grep -i "led mask" | grep -o "....1...")"

if [ -z $var ]
then
    echo "🇺🇸 English"
else
    echo "🇷🇺 Russian"
fi
