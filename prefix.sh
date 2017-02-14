#!/bin/sh

PREFIX=$1

for filename in *; do
	mv $filename $PREFIX$filename
done
