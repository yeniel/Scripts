#!/bin/sh

for filename in *.jpg; do
    convert "$filename" -resize x1024 -density 72 "${filename%.*}_1024x.png"
done


