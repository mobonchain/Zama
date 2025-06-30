#!/usr/bin/env bash
_complete_auto_commit() {
  COMPREPLY=( $(compgen -W "-s -f -m -d -n --help" -- "${COMP_WORDS[1]}") )
}
complete -F _complete_auto_commit auto_commit.sh
