#!/usr/bin/env bash

var=" $(xset -q | grep -i "led mask" | grep -o "....1...")"

if [ -z $var ]
then
    echo "πΊπΈ English"
else
    echo "π·πΊ Russian"
fi
