#!/bin/bash
used=$(du -chs / 2> /dev/null | sed '2d' | awk '{print $1}')
free=$(df -h / --total | sed '1,2d' | awk '{print $2}')
echo "Disk $used / $free"
