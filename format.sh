#!/bin/sh

FROM=$1
TO=$2

for filename in ./*.$FROM; do
	echo "$filename CONVERTED TO ${filename%.*}.$TO"
	convert $filename ${filename%.*}.$TO
	rm $filename
done
