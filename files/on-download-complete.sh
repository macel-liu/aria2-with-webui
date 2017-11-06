#!/bin/sh
# More details at https://aria2.github.io/manual/en/html/aria2c.html#event-hook

DOWNLOAD=/download
COMPLETE=/finished
SRC=$3

if [ "$2" == "0" ]; then
  exit 0
fi

while true; do
  DIR=`dirname "$SRC"`
  if [ "$DIR" == "$DOWNLOAD" ]; then
    echo `date` "INFO " "$3" moved as "$SRC"
    mv --backup=t "$SRC" "$COMPLETE"
    exit $?
  elif [ "$DIR" == "/" -o "$DIR" == "." ]; then
    echo `date` ERROR "$3" not under "$DOWNLOAD"
    exit 1
  else
    SRC=$DIR
  fi
done
