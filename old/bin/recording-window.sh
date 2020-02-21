#!/bin/sh

INFO=$(xwininfo -frame);

WIN_GEO=$(echo $INFO | grep -oEe 'geometry [0-9]+x[0-9]+' | grep -oEe '[0-9]+x[0-9]+');

WIN_XY=$(echo $INFO | grep -oEe 'Corners:\s+\+[0-9]+\+[0-9]+' | grep -oEe '[0-9]+\+[0-9]+' | sed -e 's/\+/,/' );

TIMESTAMP=$(date +%s);

avconv -f x11grab -r 25 -s $WIN_GEO -i :0.0+$WIN_XY -vcodec libx264 -pre lossless_ultrafast -threads 0 "$HOME/Downloads/video.$TIMESTAMP.mkv" &&
