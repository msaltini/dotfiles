#!/bin/bash

TEMP=$(sensors | grep "Tctl" | tr -d '+' | awk '{print $2}')
UTIL=$(top -bn1 | grep "Cpu(s)" | \
           sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | \
					 awk '{print 100 - $1"%"}')
echo $TEMP $UTIL
