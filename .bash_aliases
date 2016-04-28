# General
alias ack='ack-grep'

# See http://www.workingwith.me.uk/blog/a_useful_cvs_status_checker
alias cvs-status='cvs -q status | grep ^[?F] | grep -v "to-date"'

# See https://hub.github.com/
eval "$(hub alias -s)"

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
# Url is http://127.0.0.1:8888/
alias jupyter='docker run -v /home/jcfr/Projects/sandbox/Notebooks:/home/jovyan/work -d -p 8888:8888 jupyter/scipy-notebook start-notebook.sh'
alias jupyterkill='docker kill $(docker ps --filter "status=running" --filter "ancestor=jupyter/scipy-notebook" -q)'

