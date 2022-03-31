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

if [ -z "$HADOLINT_TRUSTED_REGISTRIES" ]; then
  unset HADOLINT_TRUSTED_REGISTRIES;
fi

if [ "$HADOLINT_RECURSIVE" = "true" ]; then
  shopt -s globstar

  filename="${!#}"
  flags="${@:1:$#-1}"

  RESULTS=$(hadolint $HADOLINT_CONFIG $flags **/$filename)
else
  # shellcheck disable=SC2086
  RESULTS=$(hadolint $HADOLINT_CONFIG "$@")
fi
FAILED=$?

if [ -n "$HADOLINT_OUTPUT" ]; then
  if [ -f "$HADOLINT_OUTPUT" ]; then
    HADOLINT_OUTPUT="$TMP_FOLDER/$HADOLINT_OUTPUT"
  fi
  echo "$RESULTS" > $HADOLINT_OUTPUT
fi

RESULTS="${RESULTS//$'\\n'/''}"
echo "::set-output name=results::$RESULTS"

{ echo "HADOLINT_RESULTS<<EOF"; echo "$RESULTS"; echo "EOF"; } >> $GITHUB_ENV

[ -z "$HADOLINT_OUTPUT" ] || echo "Hadolint output saved to: $HADOLINT_OUTPUT"

exit $FAILED
