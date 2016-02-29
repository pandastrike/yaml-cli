if [[ ! -o interactive ]]; then
    return
fi

compctl -K _yaml yaml

_yaml() {
  local word words completions
  read -cA words
  word="${words[2]}"

  if [ "${#words}" -eq 2 ]; then
    completions="$(yaml commands)"
  else
    completions="$(yaml completions "${word}")"
  fi

  reply=("${(ps:\n:)completions}")
}
