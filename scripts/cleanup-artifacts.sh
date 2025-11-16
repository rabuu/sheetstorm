#!/usr/bin/env bash
set -eu

source "$(dirname "$0")/common.sh"

dirs=(
	src/
	examples/
	template/
)

for dir in "${dirs[@]}"; do
	find "$dir" -name '*.pdf' -type f \
		-exec rm '{}' \;
done

echo 'All artifacts are cleaned up.'
