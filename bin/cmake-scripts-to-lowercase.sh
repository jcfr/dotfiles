#!/usr/bin/env bash

set -e
set -o pipefail

#
# This script automates the conversion of CMake scripts to lower case
#
# Notes:
#
# * Manual removal CMake multiline block-end command arguments is still required.
#

#
# Adapted from https://github.com/Kitware/CMake/commit/77543bd
#
# Convert CMake-language commands to lower case
#
# Ancient CMake versions required upper-case commands.  Later command
# names became case-insensitive.  Now the preferred style is lower-case.
#
# Run the following shell code:
#

cmake --help-command-list |
grep -v "cmake version" |
while read -r c; do
    echo 's/\b'"$(echo $c | tr '[:lower:]' '[:upper:]')"'\(\s*\)(/'"$c"'\1(/g'
done >convert.sed &&
git ls-files -z -- bootstrap '*.cmake' '*.cmake.in' '*CMakeLists.txt' |
xargs -0 sed -i -f convert.sed &&
rm convert.sed


#
# Adapted from https://github.com/Kitware/CMake/commit/9db3116
#
# Remove CMake-language block-end command arguments
#
# Ancient versions of CMake required else(), endif(), and similar block
# termination commands to have arguments matching the command starting the
# block.  This is no longer the preferred style.
#
# Run the following shell code:
#

for c in else endif endforeach endfunction endmacro endwhile; do
    echo 's/\b'"$c"'\(\s*\)(.\+)/'"$c"'\1()/'
done >convert.sed &&
git ls-files -z -- bootstrap '*.cmake' '*.cmake.in' '*CMakeLists.txt' |
xargs -0 sed -i -f convert.sed &&
rm convert.sed


#
# Example of commit message
#
cat <<EOF

STYLE: Convert CMake-language commands to lower case

Ancient CMake versions required upper-case commands.  Later command
names became case-insensitive.  Now the preferred style is lower-case.

The update was performed from Unix terminal using:

  bash <(curl -s https://raw.githubusercontent.com/jcfr/dotfiles/master/bin/cmake-scripts-to-lowercase.sh)
EOF
