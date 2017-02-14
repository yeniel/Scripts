#!/bin/sh

IMAGE=$1

convert $IMAGE \( +clone -background black -shadow 80x4+4+4 \) +swap -background none -layers merge +repage $IMAGE 
