#!/bin/sh

LOGO=$1

convert $LOGO -resize 640x -density 326 logo@2x.png
convert $LOGO -resize 320x -density 123 logo.png

