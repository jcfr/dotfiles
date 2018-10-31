#!/usr/bin/env bash

set -eo pipefail

output=~/.bash_aliases_ssh

echo -n "" > ${output}

pushd ~/.remmina > /dev/null
for conf_file in $(ack --type-add=remmina:ext:remmina --remmina protocol=SSH -l); do
  server=$(cat ${conf_file} | ack "^server=" | cut -d= -f2)
  ssh_username=$(cat ${conf_file} | ack "^ssh_username=" | cut -d= -f2)
  name=$(cat ${conf_file} | ack "^name=" | cut -d= -f2)

  # Copied from https://stackoverflow.com/a/94500/1539918
  # first, strip underscores
  name=${name//_/}
  # next, replace spaces with underscores
  name=${name// /_}
  # now, clean out anything that's not alphanumeric or an underscore
  name=${name//[^a-zA-Z0-9_]/}
  # finally, lowercase with TR
  name=$(echo -n $name | tr A-Z a-z)

  alias_cmd="alias ssh-connect-${name}='ssh ${ssh_username}@${server}'"
  echo "[${output}] ${alias_cmd}"
  echo ${alias_cmd} >> ${output}
done

popd > /dev/null
