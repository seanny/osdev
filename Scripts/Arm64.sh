#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd -- "${SCRIPT_DIR}/.." && pwd)"

source "${SCRIPT_DIR}/Versions.sh"
export PREFIX="${PROJECT_ROOT}/out"
export TARGET=aarch64-none-elf
export PATH="$PREFIX/bin:$PATH"
if command -v nproc >/dev/null 2>&1; then
	JOB_COUNT="$(nproc --all)"
else
	JOB_COUNT="$(sysctl -n hw.logicalcpu)"
fi
export MAKEFLAGS="-j${JOB_COUNT}"
source "${SCRIPT_DIR}/Generic.sh"

cd "${PROJECT_ROOT}"
build_binutils
build_gcc
