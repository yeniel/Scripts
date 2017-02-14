#!/bin/sh

FILES=$(find . -type f -name "*.png" -o -name "*.bmp" -o -name "*.JPG" -o -name "*.jpg")
    
for file in $FILES; do
  echo "$file resized"
  
  size=`identify "$file" | cut -f 3 -d' '`
  width=`echo $size | cut -d'x' -f 1`
  height=`echo $size | cut -d'x' -f 2`

  if test $width -gt $height 
  then
    convert $file -resize 1024x ${file%.*}_1024x.jpg
  else
    convert $file -resize x1024 ${file%.*}_x1024.jpg
  fi

  rm $file
done

rm resize.sh
