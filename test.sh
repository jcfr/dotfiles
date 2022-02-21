#!/bin/bash
set -e
set -o pipefail

(
# find all executables and run `shellcheck`
for f in $(find . -type f -not -iwholename '*.git*' | sort -u); do
	if file "$f" | grep --quiet -e shell -e bash -e aptfile; then
		shellcheck -e SC1008 "$f" && echo "[OK]: sucessfully linted $f"
	fi
done
)
