#!/bin/sh
NAME=$1
NUMBER=$2

# Portada grande en la aplicación
convert ${NAME}${NUMBER}.pdf[0] -resize 441x616 -density 300 cover_${NUMBER}.png

# Thumbnails
convert ${NAME}${NUMBER}.pdf[0] -resize 113x160 -density 300 ipad_cover_thumb_${NUMBER}.png

convert ${NAME}${NUMBER}.pdf[0] -resize 126x178 -density 300 iphone_cover_thumb_${NUMBER}.png

# Para itunes
convert ${NAME}${NUMBER}.pdf[0] -resize x1024 -density 72 ${NAME}${NUMBER}_1024x.png
convert ${NAME}${NUMBER}.pdf[0] -resize 640x920! -density 72 ${NAME}${NUMBER}_inapp.png
