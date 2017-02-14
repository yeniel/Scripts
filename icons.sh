#!/bin/sh

ICON=$1

convert $ICON -resize 57x57 -density 163 app_icon_iphone.png
convert $ICON -resize 114x114 -density 326 app_icon_iphone@2x.png
convert $ICON -resize 120x120 -density 326 app_icon_iphone_ios7@2x.png
convert $ICON -resize 72x72 -density 163 app_icon_ipad.png
convert $ICON -resize 144x144 -density 326 app_icon_ipad@2x.png
convert $ICON -resize 76x76 -density 163 app_icon_ipad_ios7.png
convert $ICON -resize 152x152 -density 326 app_icon_ipad_ios7@2x.png

convert $ICON -resize 29x29 -density 163 spotlight_icon_iphone.png
convert $ICON -resize 58x58 -density 326 spotlight_icon_iphone@2x.png
convert $ICON -resize 80x80 -density 326 spotlight_icon_iphone_ios7@2x.png
convert $ICON -resize 50x50 -density 163 spotlight_icon_ipad.png
convert $ICON -resize 100x100 -density 326 spotlight_icon_ipad@2x.png
convert $ICON -resize 40x40 -density 163 spotlight_icon_ipad_ios7.png
convert $ICON -resize 80x80 -density 326 spotlight_icon_ipad_ios7@2x.png

convert $ICON -resize 512x512 -density 163 iTunesArtwork.png
convert $ICON -resize 1024x1024 -density 326 iTunesArtwork@2x.png 
