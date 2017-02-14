#!/bin/sh

FACEBOOK_IMAGE=$2
TWITTER_IMAGE=$3

convert ${FACEBOOK_IMAGE} -resize 100x100 -density 326 facebook_icon@2x.png
convert ${FACEBOOK_IMAGE} -resize 50x50 -density 123 facebook_icon.png
convert ${TWITTER_IMAGE} -resize 100x100 -density 326 twitter_icon@2x.png
convert ${TWITTER_IMAGE} -resize 50x50 -density 123 twitter_icon.png


