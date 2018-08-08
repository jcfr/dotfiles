#!/bin/bash

# General
alias ack='ack-grep'

# See http://www.workingwith.me.uk/blog/a_useful_cvs_status_checker
alias cvs-status='cvs -q status | grep ^[?F] | grep -v "to-date"'

# See https://hub.github.com/
if which hub >/dev/null ; then
  eval "$(hub alias -s)"
fi

# Rollback modified time
alias rb='touch -d"-30min"'

# Allow gdb to attach to running processes
alias gdb-enable-attach='echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope'

# Gdrive
alias mount-kw-gdrive='google-drive-ocamlfuse -label kitware ~/mnt/gdrive-kitware/'
alias umount-kw-gdrive='fusermount -u ~/mnt/gdrive-kitware/'

# AOSP root
export AOSP_VOL=~/Projects/aosp-root/

# Start/Stop container serving jupyter based of 'scipy-notebook' stack.
stack=jupyter/scipy-notebook

# shellcheck disable=SC2139
alias jupyterdock='docker run -v /home/jcfr/Projects/sandbox/Notebooks:/home/jovyan/work -d -p 8888:8888 '${stack}' start-notebook.sh --NotebookApp.token=""'

# shellcheck disable=SC2139
alias jupyterdock_cwd='docker run -v .:/home/jovyan/work -d -p 8888:8888 '${stack}' start-notebook.sh'

# shellcheck disable=SC2139
alias jupyterdock_kill='docker kill $(docker ps --filter "status=running" --filter "ancestor='${stack}'" -q)'

alias jupyterdock_open='xdg-open http://127.0.0.1:8888'

# Drop cache
# See http://unix.stackexchange.com/questions/87908/how-do-you-empty-the-buffers-and-cache-on-a-linux-system
alias drop_caches='(sudo sysctl vm.drop_caches=1)'
