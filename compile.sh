#!/bin/bash
BASEDIR=$(dirname "$0")
osacompile -o "$BASEDIR/SVGOdrop.app" "$BASEDIR/SVGOdrop.applescript"
echo "Compiled SVGOdrop.app"