#!/bin/sh

IMAGE=$1

# PORTRAIT

names=(Default Default~iphone Default-568h@2x Default~ipad Default-Portrait@2x~ipad Default-Portrait-iOS7 Default-Portrait-iOS7@2x)
width=(320 640 640 768 1536 768 1536)
height=(480 960 1136 1004 2008 1024 2048)

for (( i = 0 ; i <  ${#height[@]} ; i++ ))
do
    echo ${names[$i]} ${width[$i]}"x"${height[$i]}
    convert $1 -resize ${width[$i]}x -gravity center -background white -extent ${width[$i]}x${height[$i]} ${names[$i]}.png
done

# LANDSCAPE

names=(Default-Landscape~ipad Default-Landscape@2x~ipad Default-Landscape-iOS7 Default-Landscape-iOS7@2x)
width=(1024 2048 1024 2048)
height=(748 1496 768 1536)

for (( i = 0 ; i <  ${#height[@]} ; i++ ))
do
    echo ${names[$i]} ${width[$i]}"x"${height[$i]}
    convert $1 -resize x${height[$i]} -gravity center -background white -extent ${width[$i]}x${height[$i]} ${names[$i]}.png
done

exit 0
