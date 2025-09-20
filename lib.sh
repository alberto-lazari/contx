error () {
  echo "$(basename "$0"): $*" >&2
  return 1
}

has_contx_files () {
  [ -n "$1" ] || error 'has_contx_files: missing directory argument'
  directory="$1"

  while IFS= read -r file; do
    [ ! -f "$directory/$file" ] || {
      unset directory
      unset file
      return 0
    }
  done <<- EOF
	$(printf '%s\n' "$CONTX_ENVRC:$CONTX_INITRC" | tr ':' '\n')
	EOF

  unset directory
  unset file

  return 1
}

use_context () {
  [ -n "$1" ] || error 'use_context: missing context argument'
  context="$1"

  # Find context to use
  while IFS= read -r contx_path; do
    if [ -d "$contx_path/$context" ] && has_contx_files "$contx_path/$context"; then
      context_dir="$contx_path/$context"
      break
    fi
  done <<- EOF
	$(printf '%s\n' "$CONTX_PATH" | tr ':' '\n')
	EOF

  # Source its initrc
  while IFS= read -r file; do
    [[ ! -f "$context_dir/$file" ]] || . "$context_dir/$file"
  done <<- EOF
	$(printf '%s\n' "$CONTX_INITRC" | tr ':' '\n')
	EOF

  unset context
  unset contx_path
  unset context_dir
  unset file
}
