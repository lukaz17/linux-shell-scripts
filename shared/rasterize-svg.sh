#!/bin/sh

################################################################################
#
#  rasterize-svg
#
#  Rasterize the SVG to PNG files.
#
#  Presquites:
#  - Inkscape
#
#  Usage:
#    rasterize-svg <image>
#
#  MIT License.
#  Copyright (C) 2025 Nguyen Nhat Tung.
#
################################################################################

set -x

if [ -z "$1" ]; then
	echo "Error: SVG file is not specified."
	return 1
fi

NAME="${1}"

if [ ! -f "${NAME}.svg" ]; then
	echo "Error: SVG file is not found."
	return 1
fi

for SIZE in "16" "24" "32" "48" "64" "72" "96" "128" "256" "512"; do
	inkscape -w "${SIZE}" -h "${SIZE}" -o "${NAME}-${SIZE}.png" "${NAME}.svg"
done
