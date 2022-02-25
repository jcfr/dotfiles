#!/usr/bin/env bash

set -eo pipefail

output=~/.bash_aliases_ssh

echo -n "" > ${output}

pushd ~/.remmina > /dev/null
for conf_file in $(ack --type-add=remmina:ext:remmina --remmina protocol=SSH -l); do
  server=$(ack "^server=" "${conf_file}" | cut -d= -f2)
  ssh_username=$(ack "^ssh_username=" "${conf_file}" | cut -d= -f2)
  name=$(ack "^name=" "${conf_file}" | cut -d= -f2)

  # Copied from https://stackoverflow.com/a/94500/1539918
  # first, strip underscores
  name=${name//_/}
  # next, replace spaces with underscores
  name=${name// /_}
  # now, clean out anything that's not alphanumeric or an underscore
  name=${name//[^a-zA-Z0-9_]/}
  # finally, lowercase with TR
  name=$(echo -n "$name" | tr "[:upper:]" "[:lower:]")

  alias_cmd="alias ssh-connect-${name}='ssh ${ssh_username}@${server}'"
  echo "[${output}] ${alias_cmd}"
  echo "${alias_cmd}" >> "${output}"
done

sort -o "${output}" "${output}"

popd > /dev/null
