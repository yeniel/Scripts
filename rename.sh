#!/bin/sh

find . -type d -print0 | while IFS= read -r -d $'\0' file; do
  echo "$file renamed"
  mv "$file" "${file//[[:space:]]/_}"  
done

find . -type f -print0 | while IFS= read -r -d $'\0' file; do
  echo "$file renamed"
  mv "$file" "${file//[[:space:]]/_}"  
done

rm rename.sh
