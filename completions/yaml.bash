_yaml() {
  COMPREPLY=()
  local word="${COMP_WORDS[COMP_CWORD]}"

  if [ "$COMP_CWORD" -eq 1 ]; then
    COMPREPLY=( $(compgen -W "$(yaml commands)" -- "$word") )
  else
    local command="${COMP_WORDS[1]}"
    local completions="$(yaml completions "$command")"
    COMPREPLY=( $(compgen -W "$completions" -- "$word") )
  fi
}

complete -F _yaml yaml
