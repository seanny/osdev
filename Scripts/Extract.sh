#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
source "${SCRIPT_DIR}/Versions.sh"

mkdir -p "${PROJECT_ROOT}/src"
cd "${PROJECT_ROOT}/src"
tar -xf "${PROJECT_ROOT}/release/binutils-${BINUTILS_VERSION}.tar.xz"
tar -xf "${PROJECT_ROOT}/release/gcc-${GCC_VERSION}.tar.xz"
