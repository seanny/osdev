#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
source "${SCRIPT_DIR}/Versions.sh"

mkdir -p "${PROJECT_ROOT}/release"
cd "${PROJECT_ROOT}/release"

download() {
	local url="$1"
	local output="$2"

	if [[ -f "${output}" ]]; then
		return
	fi
	if command -v curl >/dev/null 2>&1; then
		curl --fail --location --output "${output}" "${url}"
	elif command -v wget >/dev/null 2>&1; then
		wget --output-document="${output}" "${url}"
	else
		echo "error: curl or wget is required" >&2
		exit 1
	fi
}

download "https://ftp.gnu.org/gnu/binutils/binutils-${BINUTILS_VERSION}.tar.xz" "binutils-${BINUTILS_VERSION}.tar.xz"
download "https://ftp.gnu.org/gnu/gcc/gcc-${GCC_VERSION}/gcc-${GCC_VERSION}.tar.xz" "gcc-${GCC_VERSION}.tar.xz"

if command -v sha256sum >/dev/null 2>&1; then
	sha256sum --check "${SCRIPT_DIR}/SHA256SUMS"
else
	shasum --algorithm 256 --check "${SCRIPT_DIR}/SHA256SUMS"
fi
