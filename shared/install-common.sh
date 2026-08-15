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

set +x

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
		echo "> Create Dir:   ${_path}"
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
		echo "> Remove Item:  ${_path}"
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

	echo "> Copy Item:    ${_from} -> ${_to}"
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
	echo "> Copy Item:    ${_from} -> ${_to}"
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

	echo "> Move Item:    ${_from} -> ${_to}"
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
	echo "> Move Item:    ${_from} -> ${_to}"
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

	echo "> Link Item:    ${_from} -> ${_to}"
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
	echo "> Link Item:    ${_from} -> ${_to}"
	ln -s "${_from}" "${_to}"
}

# ------------------------------------------------------------------------------
# Make a file/folder accessible for all users
# ------------------------------------------------------------------------------
make_all_access() {
	_path="${1}"
	if [ -z "${_path}" ]; then
		echo "make_executable: Invalid arguments"
		return 1
	fi

	if [ -f "${_path}" ] || [ -d "${_path}" ]; then
		echo "> Make Public:  ${_path}"
		chmod a+wx "${_path}"
	fi
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
		echo "> Make Exec:    ${_path}"
		chmod +x "${_path}"
	fi
}

# ------------------------------------------------------------------------------
# Normalize install version for consistency
# ------------------------------------------------------------------------------
normalize_install_version() {
	_fallback_version="${1}"
	if [ -z "${INSTALL_VERSION}" ]; then
		if [ -n "${_fallback_version}" ]; then
			INSTALL_VERSION="${_fallback_version}"
		else
			echo "normalize_install_version: Install version is not specified"
			return 1
		fi
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
	_trim_prefix="${4}"
	_tag_filter="${5}"
	if [ -z "${_github_owner}" ] || [ -z "${_github_repository}" ]; then
		echo "get_install_version_from_github: Invalid arguments"
		return 1
	fi

	if [ -z "${_fallback_version}" ]; then
		if [ -n "${_tag_filter}" ]; then
			INSTALL_VERSION="$(curl -fsSL "https://api.github.com/repos/${_github_owner}/${_github_repository}/releases?per_page=20" | jq -r "[.[] | select(.tag_name | startswith(\"${_tag_filter}\"))] | first | .tag_name")"
		else
			INSTALL_VERSION="$(curl -fsSL "https://api.github.com/repos/${_github_owner}/${_github_repository}/releases/latest" | jq -r .tag_name)"
		fi
		if [ -n "${_trim_prefix}" ]; then
			INSTALL_VERSION="${INSTALL_VERSION#${_trim_prefix}}"
		fi
	else
		INSTALL_VERSION="${_fallback_version}"
	fi
	normalize_install_version
	echo "> Latest Version:  ${INSTALL_VERSION}"
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

	echo "> Init InstEnv: ${_program_id} v${_install_version} $(uname -m)"

	_user_id="$(id -u)"
	if [ "${_user_id}" -eq 0 ]; then
		INSTALL_ROOT="/usr/local/share/${_program_id}"
		SYSTEM_BIN_ROOT="/usr/local/bin"
	else
		INSTALL_ROOT="${HOME}/.local/share/${_program_id}"
		SYSTEM_BIN_ROOT="${HOME}/.local/bin"
	fi
	TEMP_ROOT="/tmp"
	USER_PROFILE_RC="${HOME}/.profile"

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
		ICON_ROOT="/usr/local/share/icons"
	else
		DESKTOP_ROOT="${HOME}/.local/share/applications"
		ICON_ROOT="${HOME}/.local/share/icons"
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
		echo "> Download Uri: ${_amd64_url} -> ${_destination}"
		curl -fSL "${_amd64_url}" -o "${_destination}"
	elif [ "${_arch}" = "aarch64" ] || [ "${_arch}" = "arm64" ]; then
		if [ -z "${_arm64_url}" ]; then
			echo "download_uri_per_arch: Unsupported architecture: ${_arch}"
			exit 1
		fi
		echo "> Download Uri: ${_arm64_url} -> ${_destination}"
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

	echo "> Extract Arch: ${_archive_file} -> ${_destination_dir}"
	if [ "${_archive_type}" = "tar" ] || [ "${_archive_type}" = "TAR" ]; then
		tar -x -v -f "${_archive_file}" -C "${_destination_dir}"
	elif [ "${_archive_type}" = "zip" ] || [ "${_archive_type}" = "ZIP" ]; then
		unzip "${_archive_file}" -d "${_destination_dir}"
	else
		echo "extract_archive: Unsupported archive type: ${_archive_type}"
		exit 1
	fi
}

# ------------------------------------------------------------------------------
# Refresh desktop icons
# ------------------------------------------------------------------------------
refresh_desktop_icon() {
	if [ -d "${HOME}/.local/share/applications" ]; then
		echo "> Refresh Desktop:  ${HOME}/.local/share/applications"
		update-desktop-database "${HOME}/.local/share/applications"
	fi
	if [ -d "${HOME}/.local/share/icons/hicolor" ]; then
		echo "> Refresh Icon:     ${HOME}/.local/share/icons/hicolor"
		gtk-update-icon-cache "${HOME}/.local/share/icons/hicolor"
	fi
	_user_id="$(id -u)"
	if [ -d "/usr/share/applications" ] && [ "${_user_id}" -eq 0 ]; then
		echo "> Refresh Desktop:   /usr/share/applications"
		update-desktop-database "/usr/share/applications"
	fi
	if [ -d "/usr/local/share/applications" ] && [ "${_user_id}" -eq 0 ]; then
		echo "> Refresh Desktop:  /usr/local/share/applications"
		update-desktop-database "/usr/local/share/applications"
	fi
	if [ -d "/usr/share/icons/hicolor" ] && [ "${_user_id}" -eq 0 ]; then
		echo "> Refresh Icon:     /usr/share/icons/hicolor"
		gtk-update-icon-cache "/usr/share/icons/hicolor"
	fi
	if [ -d "/usr/local/share/icons/hicolor" ] && [ "${_user_id}" -eq 0 ]; then
		echo "> Refresh Icon:     /usr/local/share/icons/hicolor"
		gtk-update-icon-cache "/usr/local/share/icons/hicolor"
	fi
}

# ------------------------------------------------------------------------------
# Install desktop manifest and icons
# ------------------------------------------------------------------------------
install_desktop() {
	_name="$1"
	_context_root="$2"
	_desktop_root="$3"
	_icon_root="$4"
	if [ -z "${_name}" ] || [ -z "${_context_root}" ] || [ -z "${_desktop_root}" ] || [ -z "${_icon_root}" ]; then
		echo "install_desktop: Invalid arguments"
		return 1
	fi

	echo "> Install Desktop:  ${_name}"

	if [ -f "${_context_root}/desktop/${_name}.desktop" ]; then
		copy_item_overwrite "${_context_root}/desktop/${_name}.desktop" "${_desktop_root}/${_name}.desktop"
	fi

	if [ -f "/usr/share/icons/hicolor/index.theme" ]; then
		create_dir "${_icon_root}/hicolor"
		copy_item_overwrite "/usr/share/icons/hicolor/index.theme" "${_icon_root}/hicolor/index.theme"
	fi
	for SIZE in "16" "24" "32" "48" "64" "72" "96" "128" "256" "512"; do
		FILE_FROM="${_context_root}/icon/${_name}-${SIZE}.png"
		if [ -f "${FILE_FROM}" ]; then
			DIR_TO="${_icon_root}/hicolor/${SIZE}x${SIZE}/apps"
			create_dir "${DIR_TO}"
			FILE_TO="${DIR_TO}/${_name}.png"
			copy_item_overwrite "${FILE_FROM}" "${FILE_TO}"
		fi
	done

	refresh_desktop_icon
}

# ------------------------------------------------------------------------------
# Install polkit policy (requires root)
# ------------------------------------------------------------------------------
install_polkit_policy() {
	_name="$1"
	_context_root="$2"
	if [ -z "${_name}" ] || [ -z "${_context_root}" ]; then
		echo "install_polkit_policy: Invalid arguments"
		return 1
	fi

	_user_id="$(id -u)"
	if [ "${_user_id}" -eq 0 ]; then
		echo "> Install Policy:  ${_name}"
		POLICY_SOURCE="${_context_root}/desktop/${_name}.policy"
		POLICY_TARGET="/usr/share/polkit-1/actions/${_name}.policy"
		if [ -f "${POLICY_SOURCE}" ] && [ -d "/usr/share/polkit-1/actions" ]; then
			copy_item_overwrite "${POLICY_SOURCE}" "${POLICY_TARGET}"
		fi
	fi
}

# ------------------------------------------------------------------------------
# Append text into a file
# ------------------------------------------------------------------------------
append_text_idempotent() {
	_text="$1"
	_file="$2"
	if [ -z "${_text}" ] || [ -z "${_file}" ]; then
		echo "append_text_idempotent: Invalid arguments"
		return 1
	fi
	case "${_text}" in
		*'
'*)
			echo "append_text_idempotent: Invalid arguments"
			return 1
			;;
	esac

	if ! grep -qFx "${_text}" "${_file}" 2>/dev/null; then
		if [ -s "${_file}" ]; then
			_last_line="$(tail -n 1 "${_file}")"
			if [ -n "${_last_line}" ]; then
				echo "> Updated Cfg:  ${_file}"
				printf '\n' >> "${_file}"
			fi
		fi
		printf '%s\n' "${_text}" >> "${_file}"
	fi
}

# ------------------------------------------------------------------------------
# Finalize install.
# ------------------------------------------------------------------------------
finalize_install() {
	echo "> Success."
}
