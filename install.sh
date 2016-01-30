#!/bin/bash

DESKTOP_PATH="$HOME/Desktop"

curl -sSO https://raw.githubusercontent.com/superpixel/SVGOdrop/master/svgodrop.applescript
osacompile -o "$DESKTOP_PATH/SVGOdrop.app" svgodrop.applescript
rm svgodrop.applescript
echo "Compiled SVGOdrop.app to your Desktop"