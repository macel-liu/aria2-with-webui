#!/bin/sh
# More details at https://aria2.github.io/manual/en/html/aria2c.html#event-hook
if [ $2 -eq 1 ]; then
	mv "$3" /finished
fi
