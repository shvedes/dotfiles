#!/usr/bin/env bash

weather=$(curl -s "https://wttr.in/alicante?0" | awk '(NR==4)' | awk '{print $5}')
echo "$weather°C"
