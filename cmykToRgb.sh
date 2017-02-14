#!/bin/sh

INPUT=$1
OUTPUT=tmp.pdf

gs -sDEVICE=pdfwrite -dBATCH -dNOPAUSE -dCompatibilityLevel=1.4 -dColorConversionStrategy=/RGB -dPDFUseOldCMS=false -dProcessColorModel=/DeviceRGB -dUseCIEColor=false -sOutputFile=$OUTPUT $INPUT
