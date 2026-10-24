#!/bin/sh

################################################################################
#
#  rasterize-svg
#
#  Rasterize an SVG image into PNG files of fixed sizes, one per size.
#
#  Prerequisites:
#  - Inkscape
#
#  Usage:
#    rasterize-svg <image-name>
#
#  Example:
#    rasterize-svg icon
#
#  MIT License.
#  Copyright (C) 2025 Nguyen Nhat Tung.
#
################################################################################

set -e

# Keep the size list in sync with install_desktop in shared/install-common.sh
ICON_SIZES="16 24 32 48 64 72 96 128 256 512"

check_prerequisites() {
	if ! command -v inkscape > /dev/null 2>&1; then
		echo "Error: Inkscape is not found in PATH" >&2
		return 1
	fi
}

rasterize_svg() {
	_name="${1}"
	if [ ! -f "${_name}.svg" ]; then
		echo "rasterize_svg: SVG file is not found: ${_name}.svg" >&2
		return 1
	fi

	for _size in ${ICON_SIZES}; do
		echo "> Rasterize: ${_name}-${_size}.png"
		inkscape -w "${_size}" -h "${_size}" -o "${_name}-${_size}.png" "${_name}.svg"
	done

	echo "> Success."
}

main() {
	_name="${1}"
	if [ -z "${_name}" ]; then
		echo "rasterize_svg: name of SVG image is not specified" >&2
		return 1
	fi

	_name="${_name%.svg}"

	check_prerequisites
	rasterize_svg "${_name}"
}

main "$@"
