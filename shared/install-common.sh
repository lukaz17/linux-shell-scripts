#!/bin/sh

################################################################################
#
#  install-common
#  Libraries to support *-install scripts
#
#  MIT License.
#  Copyright (C) 2025 Nguyen Nhat Tung.
#
################################################################################

# ------------------------------------------------------------------------------
# Create a directory safely
# ------------------------------------------------------------------------------
create_dir() {
	_path="${1}"
	if [ -z "${_path}" ]; then
		echo "create_dir: Invalid arguments"
		return 1
	fi

	if [ ! -d "${_path}" ]; then
		mkdir -p "${_path}"
	fi
}

# ------------------------------------------------------------------------------
# Remove file/folder safely
# ------------------------------------------------------------------------------
remove_item() {
	_path="${1}"
	if [ -z "${_path}" ]; then
		echo "remove_item: Invalid arguments"
		return 1
	fi

	if [ -f "${_path}" ] || [ -d "${_path}" ] || [ -L "${_path}" ]; then
		rm -r "${_path}"
	fi
}

# ------------------------------------------------------------------------------
# Copy file/folder safely
# ------------------------------------------------------------------------------
copy_item() {
	_from="${1}"
	_to="${2}"
	if [ -z "${_from}" ] || [ -z "${_to}" ]; then
		echo "copy_item: Invalid arguments"
		return 1
	fi

	cp -r "${_from}" "${_to}"
}

# ------------------------------------------------------------------------------
# Copy file/folder and overwrite the target
# ------------------------------------------------------------------------------
copy_item_overwrite() {
	_from="${1}"
	_to="${2}"
	if [ -z "${_from}" ] || [ -z "${_to}" ]; then
		echo "copy_item_overwrite: Invalid arguments"
		return 1
	fi

	remove_item "${_to}"
	cp -r "${_from}" "${_to}"
}

# ------------------------------------------------------------------------------
# Move file/folder safely
# ------------------------------------------------------------------------------
move_item() {
	_from="${1}"
	_to="${2}"
	if [ -z "${_from}" ] || [ -z "${_to}" ]; then
		echo "move_item: Invalid arguments"
		return 1
	fi

	mv "${_from}" "${_to}"
}

# ------------------------------------------------------------------------------
# Move file/folder and overwrite the target
# ------------------------------------------------------------------------------
move_item_overwrite() {
	_from="${1}"
	_to="${2}"
	if [ -z "${_from}" ] || [ -z "${_to}" ]; then
		echo "move_item_overwrite: Invalid arguments"
		return 1
	fi

	remove_item "${_to}"
	mv "${_from}" "${_to}"
}

# ------------------------------------------------------------------------------
# Symlink file/folder safely
# ------------------------------------------------------------------------------
symlink_item() {
	_from="${1}"
	_to="${2}"
	if [ -z "${_from}" ] || [ -z "${_to}" ]; then
		echo "symlink_item: Invalid arguments"
		return 1
	fi

	ln -s "${_from}" "${_to}"
}

# ------------------------------------------------------------------------------
# Symlink file/folder and overwrite the target
# ------------------------------------------------------------------------------
symlink_item_overwrite() {
	_from="${1}"
	_to="${2}"
	if [ -z "${_from}" ] || [ -z "${_to}" ]; then
		echo "symlink_item_overwrite: Invalid arguments"
		return 1
	fi

	remove_item "${_to}"
	ln -s "${_from}" "${_to}"
}

# ------------------------------------------------------------------------------
# Make a file/folder executable
# ------------------------------------------------------------------------------
make_executable() {
	_path="${1}"
	if [ -z "${_path}" ]; then
		echo "make_executable: Invalid arguments"
		return 1
	fi

	if [ -f "${_path}" ] || [ -d "${_path}" ]; then
		chmod +x "${_path}"
	fi
}

# ------------------------------------------------------------------------------
# Normalize install version for consistency
# ------------------------------------------------------------------------------
normalize_install_version() {
	if [ -z "${INSTALL_VERSION}" ]; then
		echo "normalize_install_version: Install version is not specified"
		return 1
	fi

	INSTALL_VERSION="${INSTALL_VERSION#v}"
}

# ------------------------------------------------------------------------------
# Get latest version from GitHub
# ------------------------------------------------------------------------------
get_install_version_from_github() {
	_github_owner="${1}"
	_github_repository="${2}"
	_fallback_version="${3}"
	if [ -z "${_github_owner}" ] || [ -z "${_github_repository}" ]; then
		echo "get_install_version_from_github: Invalid arguments"
		return 1
	fi

	if [ -z "${_fallback_version}" ]; then
		INSTALL_VERSION="$(curl -fsSL "https://api.github.com/repos/${_github_owner}/${_github_repository}/releases/latest" | jq -r .tag_name)"
	else
		INSTALL_VERSION="${_fallback_version}"
	fi
	normalize_install_version
}

# ------------------------------------------------------------------------------
# Initialize environment for the install and pre-populate root dirs
# ------------------------------------------------------------------------------
init_install_env() {
	_program_id="${1}"
	_install_version="${2}"
	if [ -z "${_program_id}" ] || [ -z "${_install_version}" ]; then
		echo "init_install_env: Invalid arguments"
		return 1
	fi

	_user_id="$(id -u)"
	if [ "${_user_id}" -eq 0 ]; then
		INSTALL_ROOT="/usr/local/share/${_program_id}"
		SYSTEM_BIN_ROOT="/usr/local/bin"
	else
		INSTALL_ROOT="${HOME}/.local/share/${_program_id}"
		SYSTEM_BIN_ROOT="${HOME}/.local/bin"
	fi
	TEMP_ROOT="/tmp"

	if [ -n "${CLIINST_USR_LOCAL_SHARE}" ]; then
		INSTALL_ROOT="${CLIINST_USR_LOCAL_SHARE}/${_program_id}"
	fi
	if [ -n "${CLIINST_TMP}" ]; then
		TEMP_ROOT="${CLIINST_TMP}"
	fi

	INSTALL_TARGET="${INSTALL_ROOT}/${_program_id}-v${_install_version}"
	ACTIVE_TARGET="${INSTALL_ROOT}/active-release"
	TEMP_TARGET="${TEMP_ROOT}/${_program_id}-v${_install_version}"

	create_dir "${INSTALL_ROOT}"
	create_dir "${SYSTEM_BIN_ROOT}"
}

# ------------------------------------------------------------------------------
# Extended version of init_install_env to support desktop environment
# ------------------------------------------------------------------------------
init_install_env_desktop() {
	init_install_env "${1}" "${2}" || return 1

	_user_id="$(id -u)"
	if [ "${_user_id}" -eq 0 ]; then
		DESKTOP_ROOT="/usr/local/share/applications"
	else
		DESKTOP_ROOT="${HOME}/.local/share/applications"
	fi
	create_dir "${DESKTOP_ROOT}"
}

# ------------------------------------------------------------------------------
# Download different file based on current system architecture
# ------------------------------------------------------------------------------
download_uri_per_arch() {
	_amd64_url="$1"
	_arm64_url="$2"
	_destination="$3"
	if [ -z "${_amd64_url}" ] && [ -z "${_arm64_url}" ]; then
		echo "download_uri_per_arch: Invalid arguments"
		return 1
	fi
	if [ -z "${_destination}" ]; then
		echo "download_uri_per_arch: Invalid arguments"
		return 1
	fi

	_arch="$(uname -m)"
	if [ "${_arch}" = "x86_64" ] || [ "${_arch}" = "amd64" ]; then
		if [ -z "${_amd64_url}" ]; then
			echo "download_uri_per_arch: Unsupported architecture: ${_arch}"
			exit 1
		fi
		curl -fSL "${_amd64_url}" -o "${_destination}"
	elif [ "${_arch}" = "aarch64" ] || [ "${_arch}" = "arm64" ]; then
		if [ -z "${_arm64_url}" ]; then
			echo "download_uri_per_arch: Unsupported architecture: ${_arch}"
			exit 1
		fi
		curl -fSL "${_arm64_url}" -o "${_destination}"
	else
		echo "download_uri_per_arch: Unsupported architecture: ${_arch}"
		exit 1
	fi
}

# ------------------------------------------------------------------------------
# Move file/folder based on current system architecture
# ------------------------------------------------------------------------------
move_item_per_arch() {
	_amd64_path="$1"
	_arm64_path="$2"
	_destination="$3"
	if [ -z "${_amd64_path}" ] && [ -z "${_arm64_path}" ]; then
		echo "move_item_per_arch: Invalid arguments"
		return 1
	fi
	if [ -z "${_destination}" ]; then
		echo "move_item_per_arch: Invalid arguments"
		return 1
	fi

	_arch="$(uname -m)"
	if [ "${_arch}" = "x86_64" ] || [ "${_arch}" = "amd64" ]; then
		if [ -z "${_amd64_path}" ]; then
			echo "move_item_per_arch: Unsupported architecture: ${_arch}"
			exit 1
		fi
		move_item "${_amd64_path}" "${_destination}"
	elif [ "${_arch}" = "aarch64" ] || [ "${_arch}" = "arm64" ]; then
		if [ -z "${_arm64_path}" ]; then
			echo "move_item_per_arch: Unsupported architecture: ${_arch}"
			exit 1
		fi
		move_item "${_arm64_path}" "${_destination}"
	else
		echo "move_item_per_arch: Unsupported architecture: ${_arch}"
		exit 1
	fi
}

# ------------------------------------------------------------------------------
# Extract archive
# ------------------------------------------------------------------------------
extract_archive() {
	_archive_file="$1"
	_archive_type="$2"
	_destination_dir="$3"
	if [ -z "${_archive_file}" ] || [ -z "${_archive_type}" ] || [ -z "${_destination_dir}" ]; then
		echo "extract_archive: Invalid arguments"
		return 1
	fi

	if [ "${_archive_type}" = "tar" ] || [ "${_archive_type}" = "TAR" ]; then
		tar -x -v -f "${_archive_file}" -C "${_destination_dir}"
	elif [ "${_archive_type}" = "zip" ] || [ "${_archive_type}" = "ZIP" ]; then
		unzip "${_archive_file}" -d "${_destination_dir}"
	else
		echo "extract_archive: Unsupported archive type: ${_archive_type}"
		exit 1
	fi
}
