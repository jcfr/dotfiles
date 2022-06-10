#!/usr/bin/env bash

set -eo pipefail

PROG_NAME=$( basename "${BASH_SOURCE[0]}" )

conf_file=${HOME}/.ssh_hosts.yml
if [[ ! -f "${conf_file}" ]]; then
  echo "[${PROG_NAME}] skipping: '${conf_file}' does not exist"
  exit 0
fi

output=~/.bash_aliases_ssh

echo -n "" > ${output}

readarray ssh_host_names < <(yq .ssh_hosts[].name "${conf_file}")
readarray ssh_host_hosts < <(yq .ssh_hosts[].host "${conf_file}")
readarray ssh_host_users < <(yq .ssh_hosts[].user "${conf_file}")

length=${#ssh_host_names[@]}

echo "[${output}]: ssh-connect-<name>, scp_from_<name>, ssh_ls_<name>"

for (( idx=0; idx<length; idx++ ));
do
  name=${ssh_host_names[$idx]%%[[:space:]]}
  # Copied from https://stackoverflow.com/a/94500/1539918
  # first, strip underscores
  name=${name//_/}
  # next, replace spaces or dots with underscores
  name=${name// /_}
  # now, clean out anything that's not alphanumeric or an underscore
  name=${name//[^a-zA-Z0-9_]/}
  # finally, lowercase with TR
  name=$(echo -n "$name" | tr "[:upper:]" "[:lower:]")

  host=${ssh_host_hosts[$idx]%%[[:space:]]}
  user=${ssh_host_users[$idx]%%[[:space:]]}

  echo "- ${name}"

  # Output of the follwing command group is redirected to the output file
  {
    echo "#-----------------------------------------------------------------------------"
    alias_cmd="alias ssh-connect-${name}='ssh ${user}@${host}'"
    echo "${alias_cmd}"

    cat << FUNCTION_SCP_FROM_EOF
scp_from_${name}() {
  if [[ ! "\$#" -eq 2 ]]; then
    echo "Usage: scp_from_${name} remote_src local_dst"
    return 1
  fi
  remote_src=\$1
  local_dst=\$2
  scp ${user}@${host}:\$remote_src \$local_dst
}
FUNCTION_SCP_FROM_EOF

    cat << FUNCTION_SCP_TO_EOF
scp_to_${name}() {
  if [[ ! "\$#" -eq 2 ]]; then
    echo "Usage: scp_to_${name} local_dst remote_src"
    return 1
  fi
  local_dst=\$1
  remote_src=\$2
  scp \$local_dst ${user}@${host}:\$remote_src
}
FUNCTION_SCP_TO_EOF

    cat << FUNCTION_SSH_LS_EOF
ssh_ls_${name}() {
  if [[ ! "\$#" -eq 1 ]]; then
    echo "Usage: ssh_ls_${name} remote_dir"
    return 1
  fi
  remote_dir=\$1
  ssh ${user}@${host} "ls \$remote_dir"
}
FUNCTION_SSH_LS_EOF

  } >> "${output}"

done
