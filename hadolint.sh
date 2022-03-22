#!/bin/bash

# The problem-matcher definition must be present in the repository
# checkout (outside the Docker container running hadolint). We copy
# problem-matcher.json to the home folder.
cp /problem-matcher.json "$HOME/"

# After the run has finished we remove the problem-matcher.json from
# the repository so we don't leave the checkout dirty. We also remove
# the matcher so it won't take effect in later steps.
cleanup() {
    echo "::remove-matcher owner=brpaz/hadolint-action::"
}
trap cleanup EXIT

echo "::add-matcher::$HOME/problem-matcher.json"

if [ -n "$HADOLINT_CONFIG" ]; then
  HADOLINT_CONFIG="-c ${HADOLINT_CONFIG}"
fi

for i in $HADOLINT_IGNORE; do
  HADOLINT_IGNORE_CMDLINE="${HADOLINT_IGNORE_CMDLINE} --ignore=${i}"
done

if [ "$HADOLINT_RECURSIVE" = "true" ]; then
  shopt -s globstar

  filename="${!#}"
  flags="${@:1:$#-1}"

  hadolint $HADOLINT_IGNORE_CMDLINE $HADOLINT_CONFIG $flags **/$filename
else
  # shellcheck disable=SC2086
  hadolint $HADOLINT_IGNORE_CMDLINE $HADOLINT_CONFIG "$@"
fi
