#!/bin/sh

CACHE_DIR=$HOME/.config/wallpapers/lock/

HASH=$(md5sum $1 | cut -f1 -d' ')
LOCK_IMG=$CACHE_DIR/$HASH.png

feh --bg-fill --no-fehbg $1

mkdir -p $CACHE_DIR

if [ ! -f $LOCK_IMG ]
then
    convert $1 -fill black -colorize 50% $LOCK_IMG
fi
ln -fs $LOCK_IMG $HOME/.config/i3/lock.png
