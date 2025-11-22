#!/usr/bin/env bash
set -eu

source "$(dirname "$0")/common.sh"

#
# See <https://github.com/cetz-package/common/blob/main/scripts/package>
#

# What files to include in package
files=(
	src/
	examples/
	template/
	docs/manual.pdf
	typst.toml
	README.md
	LICENSE
	thumbnail.png
)

function usage() {
	echo "package.sh TARGET [--version VERSION]"
	echo
	echo "Install relevant files to 'TARGET/$PKG_NAME/$PKG_VERSION'."
	echo "Set TARGET to local to install to local Typst package cache."
}

if (( $# < 1 )); then
	usage
	exit 1
fi

if [[ "${1:-}" == "help" ]] || [[ "${1:-}" == "--help" ]] || [[ "${1:-}" == "-h" ]]; then
	usage
	exit 0
fi

TARGET="${1:?Missing target path or @local}"; shift

if [[ "$TARGET" == "@local" ]] || [[ "$TARGET" == "local" ]]; then
	TARGET="${TYPST_PACKAGE_PATH}/local"
fi

while [[ $# -gt 0 ]]; do
	case "$1" in
		--version | -v)
			shift
			PKG_VERSION="${1:?No version specified}"
			shift
			;;
		--help | -h)
			usage
			exit 0
			;;
		*)
			echo "Unexpected option $1!"
			echo
			usage
			exit 1
			;;
	esac
done

echo "Package root:      $PKG_ROOT"
echo "Package name:      $PKG_NAME"
echo "Package version:   $PKG_VERSION"
echo "Install directory: $TARGET"

TMP="$(mktemp -d)"

for f in "${files[@]}"; do
	mkdir -p "$TMP/$(dirname "$f")" 2>/dev/null
	cp -r "$PKG_ROOT/$f" "$TMP/$f"
done

ACTUAL_TARGET="${TARGET:?}/${PKG_NAME:?}/${PKG_VERSION:?}"
if rm -rf "${ACTUAL_TARGET:?}" 2>/dev/null; then
	echo "Overwriting existing version."
fi

mkdir -p "$ACTUAL_TARGET"
mv "$TMP"/* "$ACTUAL_TARGET"

echo "Successfully packaged to: $ACTUAL_TARGET"
