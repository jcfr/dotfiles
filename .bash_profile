#!/bin/bash

# Load .bashrc, which loads: ~/.{aliases,functions,path,dockerfunc,extra,exports,bash_prompt}
if [[ -r "${HOME}/.bashrc" ]]; then
	# shellcheck source=/dev/null
	source "${HOME}/.bashrc"
fi
